//
//  CoreDataStoreTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
import CoreData
@testable import Shortly

class CoreDataStoreTests: XCTestCase {
    let validShortURLModel = ShortlyURLModel(code: "KCveN",
                                             shortLink: "shrtco.de/KCveN",
                                             fullShortLink: "https://shrtco.de/KCveN",
                                             shortLink2: "9qr.de/KCveN",
                                             fullShortLink2: "https://9qr.de/KCveN",
                                             shareLink: "shrtco.de/share/KCveN",
                                             fullShareLink: "https://shrtco.de/share/KCveN",
                                             originalLink: "http://example.org/very/long/link.html")

    func testFetchShortlyURL() {
        let context = CoreDataStore(.inMemory).container.newBackgroundContext()
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        let shortlyURL = ShortlyURLManagedObject(context: context)
        shortlyURL.setupWithShortlyModel(validShortURLModel)
        try! context.save()
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }

        let fetchRequest: NSFetchRequest<ShortlyURLManagedObject> = NSFetchRequest(entityName: "ShortlyURLManagedObject")
        let result = try? context.fetch(fetchRequest)
        let finalShortlyURL = result?.first

        XCTAssertEqual(result?.count, 1)
        XCTAssertEqual(finalShortlyURL?.code, shortlyURL.code)
        XCTAssertEqual(finalShortlyURL?.short_link, shortlyURL.short_link)
        XCTAssertEqual(finalShortlyURL?.full_short_link, shortlyURL.full_short_link)
        XCTAssertEqual(finalShortlyURL?.short_link2, shortlyURL.short_link2)
        XCTAssertEqual(finalShortlyURL?.full_short_link2, shortlyURL.full_short_link2)
        XCTAssertEqual(finalShortlyURL?.share_link, shortlyURL.share_link)
        XCTAssertEqual(finalShortlyURL?.full_share_link, shortlyURL.full_share_link)
        XCTAssertEqual(finalShortlyURL?.original_link, shortlyURL.original_link)
    }
}
