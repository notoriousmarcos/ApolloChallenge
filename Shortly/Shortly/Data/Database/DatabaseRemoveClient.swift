//
//  DatabaseRemoveClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public protocol DatabaseRemoveClient {
    func remove(model: ShortlyURLModel, completion: @escaping (Bool) -> Void)
}
