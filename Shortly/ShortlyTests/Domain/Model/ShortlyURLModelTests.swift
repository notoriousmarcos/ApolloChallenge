//
//  ShortlyURLModelTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 27/08/21.
//

import XCTest
@testable import Shortly

class ShortlyURLModelTests: XCTestCase {
    func testShortlyURLModel_codable_ShouldEncodeAndDecodeShortlyURLModel() throws {
        // Arrange
        let sut = ShortlyURLModel(code: "KCveN",
                                  shortLink: "shrtco.de/KCveN",
                                  fullShortLink: "https://shrtco.de/KCveN",
                                  shortLink2: "9qr.de/KCveN",
                                  fullShortLink2: "https://9qr.de/KCveN",
                                  shareLink: "shrtco.de/share/KCveN",
                                  fullShareLink: "https://shrtco.de/share/KCveN",
                                  originalLink: "http://example.org/very/long/link.html")
        let decoder = JSONDecoder()

        // Act
        guard let data = sut.toData() else {
            XCTFail("Should return a valid data.")
            return
        }
        let decodedValue = try decoder.decode(ShortlyURLModel.self, from: data)

        // Assert
        XCTAssertEqual(sut, decodedValue)
    }
}
