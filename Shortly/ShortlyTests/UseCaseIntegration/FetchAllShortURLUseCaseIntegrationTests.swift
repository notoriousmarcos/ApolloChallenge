//
//  FetchAllShortURLUseCaseIntegrationTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
import CoreData
@testable import Shortly

class FetchAllShortURLUseCaseIntegrationTests: XCTestCase {

    func testFetchAllShortURLUseCase_fetch_ShouldReceiveAllShortlyURLs() {
        // Arrange
        let context = CoreDataStore(.inMemory).container.newBackgroundContext()
        let client = CoreDataFetchAllDatabaseClient(context: context)
        let sut = DatabaseFetchAllShortURLUseCase(databaseClient: client)
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

        let exp = expectation(description: "Waiting request")

        // Act
        sut.execute { result in
            // Assert
            switch result {
                case .success(let urls):
                    XCTAssertEqual(urls.count, 1)
                    XCTAssertEqual(urls.first?.code, model.code)
                    XCTAssertEqual(urls.first?.shortLink, model.shortLink)
                    XCTAssertEqual(urls.first?.fullShortLink, model.fullShortLink)
                    XCTAssertEqual(urls.first?.shortLink2, model.shortLink2)
                    XCTAssertEqual(urls.first?.fullShortLink2, model.fullShortLink2)
                    XCTAssertEqual(urls.first?.shareLink, model.shareLink)
                    XCTAssertEqual(urls.first?.fullShareLink, model.fullShareLink)
                    XCTAssertEqual(urls.first?.originalLink, model.originalLink)
                case .failure:
                    XCTFail("Should be success")
            }
            exp.fulfill()

        }

        wait(for: [exp], timeout: 1)
    }
}
