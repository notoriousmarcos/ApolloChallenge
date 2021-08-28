//
//  MockShortURLDatabaseFetchAllClient.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation
import XCTest
@testable import Shortly

class MockShortURLDatabaseFetchAllClient: DatabaseFetchAllClient {
    var result: [ShortlyURLModel]?

    func fetchAll(completion: @escaping ([ShortlyURLModel]) -> Void) {
        guard let result = result else {
            return XCTFail("Result Should not be nil")
        }
        completion(result)
    }
}
