//
//  CoreDataShortURLDatabaseRemoveClientTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
import CoreData
@testable import Shortly

class CoreDataShortURLDatabaseRemoveClientTests: XCTestCase {

    func testCoreDataShortURLDatabaseRemoveClient_removeModel_ShouldReturnSuccess() throws {
        // Arrange
        let validShortURLModel = ShortlyURLModel(code: "KCveN",
                                                 shortLink: "shrtco.de/KCveN",
                                                 fullShortLink: "https://shrtco.de/KCveN",
                                                 shortLink2: "9qr.de/KCveN",
                                                 fullShortLink2: "https://9qr.de/KCveN",
                                                 shareLink: "shrtco.de/share/KCveN",
                                                 fullShareLink: "https://shrtco.de/share/KCveN",
                                                 originalLink: "http://example.org/very/long/link.html")
        let context = CoreDataStore(.inMemory).container.newBackgroundContext()
        let sut = CoreDataShortURLDatabaseRemoveClient(context: context)
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        let shortlyURL = ShortlyURLManagedObject(context: context)
        shortlyURL.setupWithShortlyModel(validShortURLModel)
        try! context.save()
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Save did not occur")
        }

        let fetchRequest: NSFetchRequest<ShortlyURLManagedObject> = NSFetchRequest(entityName: "ShortlyURLManagedObject")
        var result = try? context.fetch(fetchRequest)

        XCTAssertEqual(result?.count, 1)

        // Act
        sut.remove(model: validShortURLModel) { success in
            // Assert
            XCTAssertTrue(success)
        }

        result = try? context.fetch(fetchRequest)

        XCTAssertTrue(result?.isEmpty ?? false)
    }
}
