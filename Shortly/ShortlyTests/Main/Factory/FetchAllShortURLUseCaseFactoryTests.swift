//
//  FetchAllURLUsecaseFactoryTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 29/08/21.
//

import XCTest
@testable import Shortly

class FetchAllURLUsecaseFactoryTests: XCTestCase {

    func testFetchAllURLUsecaseFactory_make_ShouldReceiveFetchAllURLUseCase() {
        let sut = FetchAllURLUsecaseFactory()

        XCTAssert(sut.make(withStore: CoreDataStore(.inMemory)) is DatabaseFetchAllShortURLUseCase)
    }

}
