//
//  DatabaseSaveClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

protocol DatabaseSaveClient {
    associatedtype T
    func save(model: T, completion: @escaping (Bool) -> Void)
}
