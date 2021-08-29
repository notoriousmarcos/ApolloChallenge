//
//  RemoveShortURLUseCaseFactoryTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 29/08/21.
//

import XCTest
@testable import Shortly

class RemoveShortURLUseCaseFactoryTests: XCTestCase {

    func testSaveURLUsecaseFactory_make_ShouldReceiveRemoveShortURLUseCase() {
        let sut = RemoveShortURLUseCaseFactory()

        XCTAssert(sut.make(withStore: CoreDataStore(.inMemory)) is DatabaseRemoveShortURLUseCase)
    }

}
