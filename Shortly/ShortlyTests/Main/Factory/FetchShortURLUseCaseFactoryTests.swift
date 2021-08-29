//
//  FetchShortURLUseCaseFactoryTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 29/08/21.
//

import XCTest
@testable import Shortly

class FetchShortURLUseCaseFactoryTests: XCTestCase {

    func testFetchURLUsecaseFactory_make_ShouldReceiveFetchAllURLUseCase() {
        let sut = FetchShortURLUseCaseFactory()

        XCTAssert(sut.make() is RemoteFetchShortURLUseCase)
    }

}
