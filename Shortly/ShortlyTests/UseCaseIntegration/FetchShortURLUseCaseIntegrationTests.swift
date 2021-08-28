//
//  FetchShortURLUseCaseIntegrationTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
@testable import Shortly

class FetchShortURLUseCaseIntegrationTests: XCTestCase {

    func testFetchShortURLUseCase_fetch_ShouldReceiveShortlyURL() {
        // Arrange
        let httpClient = NativeHTTPGetClient()
        let url = URL(string: "https://api.shrtco.de/v2/shorten")!
        let sut = RemoteFetchShortURLUseCase(url: url, httpClient: httpClient)
        let model = FetchShortURLUseCaseModel(url: "https://www.google.com")

        let exp = expectation(description: "Waiting request")
        // Act
        sut.execute(model) { result in
            // Assert
            switch result {
                case .success(let shortURL):
                    XCTAssertEqual(shortURL.originalLink, model.url)
                case .failure(let error):
                    XCTFail("Should return a valid Shortly:\n\(error.localizedDescription)")
            }
            exp.fulfill()
        }

        // This API take a long long time :(
        wait(for: [exp], timeout: 60)
    }

}
