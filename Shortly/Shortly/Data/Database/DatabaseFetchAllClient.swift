//
//  DatabaseFetchAllClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

protocol DatabaseFetchAllClient {
    associatedtype T
    func fetchAll(completion: @escaping (T) -> Void)
}
