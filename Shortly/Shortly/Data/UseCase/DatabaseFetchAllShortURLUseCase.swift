//
//  DatabaseFetchAllShortURLUseCase.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation

public class DatabaseFetchAllShortURLUseCase: FetchAllShortURLUseCase {
    public let databaseClient: DatabaseFetchAllClient

    init(databaseClient: DatabaseFetchAllClient) {
        self.databaseClient = databaseClient
    }

    public func execute(completion: @escaping (FetchAllShortURLUseCase.Result) -> Void) {
        databaseClient.fetchAll { result in
            switch result {
                case .success(let urls):
                    completion(.success(urls))
                case .failure:
                    completion(.failure(.unknown))
            }
        }
    }
}
