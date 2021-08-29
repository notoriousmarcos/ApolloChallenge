//
//  RemoveShortURLUseCaseIntegrationTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
import CoreData
@testable import Shortly

class RemoveShortURLUseCaseIntegrationTests: XCTestCase {

    func testRemoveShortURLUseCase_remove_ShouldReceiveSuccess() {
        // Arrange
        let context = CoreDataStore(.inMemory).container.newBackgroundContext()
        let client = CoreDataShortURLDatabaseRemoveClient(context: context)
        let sut = DatabaseRemoveShortURLUseCase(databaseClient: client)
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
        let shortlyURL = ShortlyURLManagedObject(context: context)
        shortlyURL.setupWithShortlyModel(model)
        try! context.save()
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Save did not occur")
        }

        // Act
        sut.execute(model) { success in
            XCTAssertTrue(success)
        }
    }
}
