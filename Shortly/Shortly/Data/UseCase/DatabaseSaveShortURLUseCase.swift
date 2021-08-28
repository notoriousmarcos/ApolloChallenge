//
//  DatabaseSaveShortURLUseCase.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public class DatabaseSaveShortURLUseCase: SaveShortURLUseCase {

    public let databaseClient: DatabaseSaveClient

    public init(databaseClient: DatabaseSaveClient) {
        self.databaseClient = databaseClient
    }

    public func execute(_ model: ShortlyURLModel, completion: @escaping (Bool) -> Void) {
        databaseClient.save(model: model) { result in
            switch result {
                case .success(let bool):
                    completion(bool)
                case .failure:
                    completion(false)
            }
        }
    }
}
