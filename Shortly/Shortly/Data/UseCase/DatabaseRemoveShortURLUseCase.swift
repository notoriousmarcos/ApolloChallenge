//
//  DatabaseRemoveShortURLUseCase.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public class DatabaseRemoveShortURLUseCase: RemoveShortURLUseCase {

    public let databaseClient: DatabaseRemoveClient

    public init(databaseClient: DatabaseRemoveClient) {
        self.databaseClient = databaseClient
    }

    public func execute(_ model: ShortlyURLModel, completion: @escaping (Bool) -> Void) {
        databaseClient.remove(model: model) { result in
            completion(result)
        }
    }
}
