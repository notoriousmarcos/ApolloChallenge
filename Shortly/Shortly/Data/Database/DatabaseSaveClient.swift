//
//  DatabaseSaveClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public protocol DatabaseSaveClient {
    typealias Result = Swift.Result<Bool, DatabaseError>
    func save(model: ShortlyURLModel, completion: @escaping (Result) -> Void)
}
