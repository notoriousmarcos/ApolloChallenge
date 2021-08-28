//
//  HTTPPostClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public protocol HTTPPostClient {
    typealias Result = Swift.Result<Data?, HTTPError>
    func post(to url: URL, with data: Data?, completion: @escaping (Result) -> Void)
}
