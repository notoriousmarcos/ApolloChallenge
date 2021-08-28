//
//  DatabaseSaveShortURLUseCaseTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
@testable import Shortly

class DatabaseSaveShortURLUseCaseTests: XCTestCase {

    let mockClient = MockShortURLDatabaseSaveClient()
    let validShortURLModel = ShortlyURLModel(code: "KCveN",
                                             shortLink: "shrtco.de/KCveN",
                                             fullShortLink: "https://shrtco.de/KCveN",
                                             shortLink2: "9qr.de/KCveN",
                                             fullShortLink2: "https://9qr.de/KCveN",
                                             shareLink: "shrtco.de/share/KCveN",
                                             fullShareLink: "https://shrtco.de/share/KCveN",
                                             originalLink: "http://example.org/very/long/link.html")

    func testDatabaseSaveShortURLUseCase_executeWithValidData_ShouldReturnSuccess() {
        // Arrange
        mockClient.result = true
        let sut = DatabaseSaveShortURLUseCase(databaseClient: mockClient)

        // Act
        sut.execute(validShortURLModel) { [weak self] success in
            // Assert
            XCTAssertTrue(success)
            XCTAssertEqual(self?.mockClient.savedModel, self?.validShortURLModel)
        }
    }

    func testDatabaseSaveShortURLUseCase_executeWithFail_ShouldReturnFail() {
        // Arrange
        mockClient.result = false
        let sut = DatabaseSaveShortURLUseCase(databaseClient: mockClient)

        // Act
        sut.execute(validShortURLModel) { success in
            // Assert
            XCTAssertFalse(success)
        }
    }
}
