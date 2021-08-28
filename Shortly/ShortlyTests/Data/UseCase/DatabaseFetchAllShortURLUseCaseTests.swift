//
//  DatabaseFetchAllShortURLUseCaseTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
@testable import Shortly

public class DatabaseFetchAllShortURLUseCase: FetchAllShortURLUseCase {
    public let databaseClient: DatabaseFetchAllClient

    init(databaseClient: DatabaseFetchAllClient) {
        self.databaseClient = databaseClient
    }

    public func execute(completion: @escaping (FetchAllShortURLUseCase.Result) -> Void) {
        databaseClient.fetchAll { result in
            switch result {
                case .success(let urls):
                    completion(.success(urls))
                case .failure:
                    completion(.failure(.unknown))
            }
        }
    }
}

class DatabaseFetchAllShortURLUseCaseTests: XCTestCase {

    let mockClient = MockShortURLDatabaseFetchAllClient()

    func testDatabaseFetchAllShortURLUseCase_executeWithValidData_ShouldReturnAValidArray() {
        // Arrange
        let validShortURLModel = ShortlyURLModel(code: "KCveN",
                                                 shortLink: "shrtco.de/KCveN",
                                                 fullShortLink: "https://shrtco.de/KCveN",
                                                 shortLink2: "9qr.de/KCveN",
                                                 fullShortLink2: "https://9qr.de/KCveN",
                                                 shareLink: "shrtco.de/share/KCveN",
                                                 fullShareLink: "https://shrtco.de/share/KCveN",
                                                 originalLink: "http://example.org/very/long/link.html")
        mockClient.result = .success([validShortURLModel])
        let sut = DatabaseFetchAllShortURLUseCase(databaseClient: mockClient)

        // Act
        sut.execute() { result in
            // Assert
            if case let .success(shortURLs) = result {
                XCTAssertEqual(shortURLs, [validShortURLModel])
            } else {
                XCTFail("Should receive a valid response")
            }
        }
    }

    func testDatabaseFetchAllShortURLUseCase_executeWithValidData_ShouldReturnAnError() {
        // Arrange
        mockClient.result = .failure(.unknown)
        let sut = DatabaseFetchAllShortURLUseCase(databaseClient: mockClient)

        // Act
        sut.execute() { result in
            // Assert
            if case let .failure(error) = result {
                XCTAssertEqual(error, .unknown)
            } else {
                XCTFail("Should receive an unknown error")
            }
        }
    }
}
