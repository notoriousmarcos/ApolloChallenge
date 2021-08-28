//
//  DomainErrorTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import XCTest
@testable import Shortly

class DomainErrorTests: XCTestCase {

    func testDomainError_initWithRawValue_ShouldReceiveCorrectError() {
        XCTAssertEqual(DomainError(rawValue: 1), .emptyURL)
        XCTAssertEqual(DomainError(rawValue: 2), .invalidURL)
        XCTAssertEqual(DomainError(rawValue: 3), .rateLimitReached)
        XCTAssertEqual(DomainError(rawValue: 4), .ipBlocked)
        XCTAssertEqual(DomainError(rawValue: 5), .shortCodeInUse)
        XCTAssertEqual(DomainError(rawValue: 6), .unknown)
        XCTAssertEqual(DomainError(rawValue: 9), .missingParams)
        XCTAssertEqual(DomainError(rawValue: 10), .disallowedLink)
    }
}
