//
//  MockHTTPGetClient.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation
import XCTest
@testable import Shortly

class MockHTTPGetClient: HTTPGetClient {
    var result: HTTPGetClient.Result?

    func get(to url: URL, with data: Data?, completion: @escaping (HTTPGetClient.Result) -> Void) {
        guard let result = result else {
            return XCTFail("Result Should not be nil")
        }
        completion(result)
    }
}
