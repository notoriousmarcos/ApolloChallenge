//
//  RemoteFetchShortURLUseCaseTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
@testable import Shortly

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

    func testRemoteFetchShortURLUseCase_executeWithNilData_ShouldReturnUnknownError() {
        // Arrange
        mockClient.result = .success(nil)
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
        mockClient.result = .success(MockResponses.invalidFetchShortURLUseResponseWithEmptyURL.toData())
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

        static let invalidFetchShortURLUseResponseWithEmptyURL = FetchShortURLUseResponse(ok: false,
                                                                                         error_code: 1,
                                                                                         error: "EmptyURL",
                                                                                         result: nil)
    }
}
