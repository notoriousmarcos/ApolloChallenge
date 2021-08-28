//
//  CoreDataShortURLDatabaseSaveClientTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
import CoreData
@testable import Shortly

public class CoreDataShortURLDatabaseSaveClient: DatabaseSaveClient {

    public let context: NSManagedObjectContext

    public init(context: NSManagedObjectContext) {
        self.context = context
    }

    public func save(model: ShortlyURLModel, completion: @escaping (Bool) -> Void) {
        let shortlyURL = ShortlyURLManagedObject(context: context)
        shortlyURL.setupWithShortlyModel(model)
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
}

class CoreDataShortURLDatabaseSaveClientTests: XCTestCase {

    let validShortURLModel = ShortlyURLModel(code: "KCveN",
                                             shortLink: "shrtco.de/KCveN",
                                             fullShortLink: "https://shrtco.de/KCveN",
                                             shortLink2: "9qr.de/KCveN",
                                             fullShortLink2: "https://9qr.de/KCveN",
                                             shareLink: "shrtco.de/share/KCveN",
                                             fullShareLink: "https://shrtco.de/share/KCveN",
                                             originalLink: "http://example.org/very/long/link.html")

    func testCoreDataShortURLDatabaseSaveClient_saveModel_ShouldReturnSuccess() throws {
        // Arrange
        let context = CoreDataStore(.inMemory).container.newBackgroundContext()
        let sut = CoreDataShortURLDatabaseSaveClient(context: context)
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        
        // Act
        sut.save(model: validShortURLModel) { success in
            // Assert
            XCTAssertTrue(success)
        }

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }

        let fetchRequest: NSFetchRequest<ShortlyURLManagedObject> = NSFetchRequest(entityName: "ShortlyURLManagedObject")
        let result = try? context.fetch(fetchRequest)
        let finalShortlyURL = result?.first

        XCTAssertEqual(result?.count, 1)
        XCTAssertEqual(finalShortlyURL?.code, validShortURLModel.code)
        XCTAssertEqual(finalShortlyURL?.short_link, validShortURLModel.shortLink)
        XCTAssertEqual(finalShortlyURL?.full_short_link, validShortURLModel.fullShortLink)
        XCTAssertEqual(finalShortlyURL?.short_link2, validShortURLModel.shortLink2)
        XCTAssertEqual(finalShortlyURL?.full_short_link2, validShortURLModel.fullShortLink2)
        XCTAssertEqual(finalShortlyURL?.share_link, validShortURLModel.shareLink)
        XCTAssertEqual(finalShortlyURL?.full_share_link, validShortURLModel.fullShareLink)
        XCTAssertEqual(finalShortlyURL?.original_link, validShortURLModel.originalLink)
        
    }

}
