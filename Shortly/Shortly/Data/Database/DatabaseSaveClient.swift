//
//  DatabaseSaveClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public protocol DatabaseSaveClient {
    func save(model: ShortlyURLModel, completion: @escaping (Bool) -> Void)
}
