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
                    if let model: ShortlyURLModel = data?.toModel() {
                        completion(.success(model))
                    } else {
                        completion(.failure(.unknown))
                    }
                case .failure(let error):
                    completion(.failure(FetchShortURLError.unknown))
            }
        }
    }
}

class RemoteFetchShortURLUseCaseTests: XCTestCase {

    let url = URL(string: "https://api.shrtco.de/v2/shorten")!
    let mockClient = MockHTTPPostClient()

    func testRemoteFetchShortURLUseCase_execute_ShouldReturnAValidShortURL() {
        // Arrange
        mockClient.result = .success(MockResponses.validShortURLModel.toData())
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

    struct MockResponses {
        static let validShortURLModel = ShortlyURLModel(code: "KCveN",
                                                        shortLink: "shrtco.de/KCveN",
                                                        fullShortLink: "https://shrtco.de/KCveN",
                                                        shortLink2: "9qr.de/KCveN",
                                                        fullShortLink2: "https://9qr.de/KCveN",
                                                        shareLink: "shrtco.de/share/KCveN",
                                                        fullShareLink: "https://shrtco.de/share/KCveN",
                                                        originalLink: "http://example.org/very/long/link.html")
    }
}
