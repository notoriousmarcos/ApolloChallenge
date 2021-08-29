//
//  SaveShortURLUseCaseIntegrationTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
@testable import Shortly

class SaveShortURLUseCaseIntegrationTests: XCTestCase {

    func testSaveShortURLUseCase_save_ShouldReceiveTrue() {
        // Arrange
        let context = CoreDataStore(.inMemory).container.newBackgroundContext()
        let client = CoreDataShortURLDatabaseSaveClient(context: context)
        let sut = DatabaseSaveShortURLUseCase(databaseClient: client)
        let model = ShortlyURLModel(code: "KCveN",
                                                 shortLink: "shrtco.de/KCveN",
                                                 fullShortLink: "https://shrtco.de/KCveN",
                                                 shortLink2: "9qr.de/KCveN",
                                                 fullShortLink2: "https://9qr.de/KCveN",
                                                 shareLink: "shrtco.de/share/KCveN",
                                                 fullShareLink: "https://shrtco.de/share/KCveN",
                                                 originalLink: "http://example.org/very/long/link.html")

        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        // Act
        sut.execute(model) { success in
            // Assert
            XCTAssertTrue(success)
        }

        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }

}
