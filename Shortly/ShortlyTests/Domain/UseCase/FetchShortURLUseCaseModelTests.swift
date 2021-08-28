//
//  FetchShortURLUseCaseModelTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
@testable import Shortly

class FetchShortURLUseCaseModelTests: XCTestCase {

    func testFetchShortURLUseCaseModel_codable_ShouldEncodeAndDecodeFetchShortURLUseCaseModel() throws {
        // Arrange
        let sut = FetchShortURLUseCaseModel(url: "http://example.org/very/long/link.html")
        let decoder = JSONDecoder()

        // Act
        guard let data = sut.toData() else {
            XCTFail("Should return a valid data.")
            return
        }
        let decodedValue = try decoder.decode(FetchShortURLUseCaseModel.self, from: data)

        // Assert
        XCTAssertEqual(sut, decodedValue)
    }

}
