//
//  DatabaseFetchAllClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public protocol DatabaseFetchAllClient {
    typealias Result = Swift.Result<[ShortlyURLModel], DatabaseError>
    func fetchAll(completion: @escaping (Result) -> Void)
}
