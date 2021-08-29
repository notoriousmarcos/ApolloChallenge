//
//  ShortlyURLViewModelTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 29/08/21.
//

import XCTest
@testable import Shortly

class ShortlyURLViewModelTests: XCTestCase {

    func testShortlyURLViewModel_init_ShouldRetainProperties() throws {
        // Arrange
        let sut = ShortlyURLViewModel(code: "KCveN",
                             shortLink: "shrtco.de/KCveN",
                             originalLink: "http://example.org/very/long/link.html")

        // Assert
        XCTAssertEqual(sut.code, "KCveN")
        XCTAssertEqual(sut.shortLink, "shrtco.de/KCveN")
        XCTAssertEqual(sut.originalLink, "http://example.org/very/long/link.html")
    }

}
