//
//  DatabaseSaveClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public protocol DatabaseSaveClient {
    typealias Result = Swift.Result<Bool, DatabaseError>
    associatedtype T
    func save(model: T, completion: @escaping (Result) -> Void)
}
