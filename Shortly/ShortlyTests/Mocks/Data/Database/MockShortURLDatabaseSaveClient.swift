//
//  MockShortURLDatabaseSaveClient.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation
import XCTest
@testable import Shortly

class MockShortURLDatabaseSaveClient: DatabaseSaveClient {

    var result: Bool?
    var savedModel: ShortlyURLModel?

    func save(model: ShortlyURLModel, completion: @escaping (Bool) -> Void) {
        guard let result = result else {
            return XCTFail("Result Should not be nil")
        }
        savedModel = model
        completion(result)
    }
}
