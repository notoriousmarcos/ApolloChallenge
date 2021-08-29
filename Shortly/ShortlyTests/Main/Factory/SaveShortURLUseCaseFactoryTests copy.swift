//
//  SaveShortURLUseCaseFactoryTests.swift
//  ShortlyTests
//
//  Created by marcos.brito on 29/08/21.
//

import XCTest
@testable import Shortly

class SaveShortURLUseCaseFactoryTests: XCTestCase {

    func testSaveURLUsecaseFactory_make_ShouldReceiveSaveShortURLUseCase() {
        let sut = SaveShortURLUseCaseFactory()

        XCTAssert(sut.make(withStore: CoreDataStore(.inMemory)) is DatabaseSaveShortURLUseCase)
    }

}
