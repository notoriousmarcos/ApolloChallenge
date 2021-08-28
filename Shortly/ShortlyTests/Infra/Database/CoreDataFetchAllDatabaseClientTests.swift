//
//  CoreDataFetchAllClient.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
import CoreData
@testable import Shortly

class CoreDataFetchAllDatabaseClientTests: XCTestCase {

    func testCoreDataFetchAllDatabaseClient_fetchAll_ShouldReturnAnArrayWithShortlyURL() throws {
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
        let sut = CoreDataFetchAllDatabaseClient(context: context)
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }

        let shortlyURL = ShortlyURLManagedObject(context: context)
        shortlyURL.setupWithShortlyModel(validShortURLModel)
        try! context.save()
        waitForExpectations(timeout: 1) { error in
            XCTAssertNil(error, "Save did not occur")
        }

        // Act
        sut.fetchAll { result in
            switch result {
                case .success(let urls):
                    XCTAssertEqual(urls.count, 1)
                    XCTAssertEqual(urls.first?.code, validShortURLModel.code)
                    XCTAssertEqual(urls.first?.shortLink, validShortURLModel.shortLink)
                    XCTAssertEqual(urls.first?.fullShortLink, validShortURLModel.fullShortLink)
                    XCTAssertEqual(urls.first?.shortLink2, validShortURLModel.shortLink2)
                    XCTAssertEqual(urls.first?.fullShortLink2, validShortURLModel.fullShortLink2)
                    XCTAssertEqual(urls.first?.shareLink, validShortURLModel.shareLink)
                    XCTAssertEqual(urls.first?.fullShareLink, validShortURLModel.fullShareLink)
                    XCTAssertEqual(urls.first?.originalLink, validShortURLModel.originalLink)
                case .failure:
                    XCTFail("Should be success")
            }
        }
    }

    func testCoreDataFetchAllDatabaseClient_fetchAll_ShouldReturnAnEmptyArray() throws {
        // Arrange

        let context = CoreDataStore(.inMemory).container.newBackgroundContext()
        let sut = CoreDataFetchAllDatabaseClient(context: context)

        // Act
        sut.fetchAll { result in
            switch result {
                case .success(let urls):
                    XCTAssertTrue(urls.isEmpty)
                case .failure:
                    XCTFail("Should be success")
            }
        }
    }

}
