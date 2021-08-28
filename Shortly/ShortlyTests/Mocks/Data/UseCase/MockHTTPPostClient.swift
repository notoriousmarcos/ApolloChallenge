//
//  MockHTTPPostClient.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation
import XCTest
@testable import Shortly

class MockHTTPPostClient: HTTPPostClient {
    var result: HTTPPostClient.Result?

    func post(to url: URL, with data: Data?, completion: @escaping (HTTPPostClient.Result) -> Void) {
        guard let result = result else {
            return XCTFail("Result Should not be nil")
        }
        completion(result)
    }
}
