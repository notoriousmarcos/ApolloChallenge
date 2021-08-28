//
//  RemoteFetchShortURLUseCaseTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
@testable import Shortly

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}

public class RemoteFetchShortURLUseCase: FetchShortURLUseCase {
    private let url: URL
    private let httpClient: HTTPPostClient

    public init(url: URL, httpClient: HTTPPostClient) {
        self.url = url
        self.httpClient = httpClient
    }

    public func execute(_ fetchURLModel: FetchShortURLUseCaseModel, completion: @escaping (FetchShortURLUseCase.Result) -> Void) {
        httpClient.post(to: url, with: fetchURLModel.toData()) { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(let data):
                    guard let model: FetchShortURLUseResponse = data?.toModel() else {
                        return completion(.failure(.unknown))
                    }

                    self?.parseResponseToResult(model, completion: completion)
                case .failure:
                    completion(.failure(.unknown))
            }
        }
    }

    private func parseResponseToResult(_ response: FetchShortURLUseResponse, completion: @escaping (FetchShortURLUseCase.Result) -> Void) {
        if response.ok, let shortURL = response.result  {
            completion(.success(shortURL))
        } else if let error = response.error_code {
            completion(.failure(FetchShortURLError(rawValue: error) ?? .unknown))
        } else {
            completion(.failure(.unknown))
        }
    }
}

class RemoteFetchShortURLUseCaseTests: XCTestCase {

    let url = URL(string: "https://api.shrtco.de/v2/shorten")!
    let mockClient = MockHTTPPostClient()

    func testRemoteFetchShortURLUseCase_executeWithValidData_ShouldReturnAValidShortURL() {
        // Arrange
        mockClient.result = .success(MockResponses.validFetchShortURLUseResponse.toData())
        let sut = RemoteFetchShortURLUseCase(url: url, httpClient: mockClient)

        // Act
        sut.execute(FetchShortURLUseCaseModel(url: "http://example.org/very/long/link.html")) { result in
            // Assert
            if case let .success(shortURL) = result {
                XCTAssertEqual(shortURL, MockResponses.validShortURLModel)
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testRemoteFetchShortURLUseCase_executeWithInvalidData_ShouldReturnUnknownError() {
        // Arrange
        mockClient.result = .success(MockResponses.validFetchShortURLUseResponseWithEmptyData.toData())
        let sut = RemoteFetchShortURLUseCase(url: url, httpClient: mockClient)

        // Act
        sut.execute(FetchShortURLUseCaseModel(url: "http://example.org/very/long/link.html")) { result in
            // Assert
            if case let .failure(error) = result {
                XCTAssertEqual(error, .unknown)
            } else {
                XCTFail("Should receive a unknown error")
            }
        }
    }

    func testRemoteFetchShortURLUseCase_executeWithEmptyURL_ShouldReturnEmptyURL() {
        // Arrange
        mockClient.result = .success(MockResponses.validFetchShortURLUseResponseWithEmptyURL.toData())
        let sut = RemoteFetchShortURLUseCase(url: url, httpClient: mockClient)

        // Act
        sut.execute(FetchShortURLUseCaseModel(url: "")) { result in
            // Assert
            if case let .failure(error) = result {
                XCTAssertEqual(error, .emptyURL)
            } else {
                XCTFail("Should receive a unknown error")
            }
        }
    }

    struct MockResponses {
        static let validShortURLModel = ShortlyURLModel(code: "KCveN",
                                                        shortLink: "shrtco.de/KCveN",
                                                        fullShortLink: "https://shrtco.de/KCveN",
                                                        shortLink2: "9qr.de/KCveN",
                                                        fullShortLink2: "https://9qr.de/KCveN",
                                                        shareLink: "shrtco.de/share/KCveN",
                                                        fullShareLink: "https://shrtco.de/share/KCveN",
                                                        originalLink: "http://example.org/very/long/link.html")

        static let validFetchShortURLUseResponse = FetchShortURLUseResponse(ok: true,
                                                                            error_code: nil,
                                                                            error: nil,
                                                                            result: validShortURLModel)

        static let validFetchShortURLUseResponseWithEmptyData = FetchShortURLUseResponse(ok: true,
                                                                            error_code: nil,
                                                                            error: nil,
                                                                            result: nil)

        static let validFetchShortURLUseResponseWithEmptyURL = FetchShortURLUseResponse(ok: true,
                                                                                         error_code: 1,
                                                                                         error: "EmptyURL",
                                                                                         result: nil)
    }
}
