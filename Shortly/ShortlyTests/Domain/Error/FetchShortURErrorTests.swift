//
//  FetchShortURLErrorTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
@testable import Shortly

class FetchShortURLErrorTests: XCTestCase {

    func testDomainError_initWithRawValue_ShouldReceiveCorrectError() {
        XCTAssertEqual(FetchShortURLError(rawValue: 1), .emptyURL)
        XCTAssertEqual(FetchShortURLError(rawValue: 2), .invalidURL)
        XCTAssertEqual(FetchShortURLError(rawValue: 3), .rateLimitReached)
        XCTAssertEqual(FetchShortURLError(rawValue: 4), .ipBlocked)
        XCTAssertEqual(FetchShortURLError(rawValue: 5), .shortCodeInUse)
        XCTAssertEqual(FetchShortURLError(rawValue: 6), .unknown)
        XCTAssertEqual(FetchShortURLError(rawValue: 9), .missingParams)
        XCTAssertEqual(FetchShortURLError(rawValue: 10), .disallowedLink)
    }
}
