//
//  HTTPGetClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public protocol HTTPGetClient {
    typealias Result = Swift.Result<Data?, HTTPError>
    func get(to url: URL, with data: Data?, completion: @escaping (Result) -> Void)
}
