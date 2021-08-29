//
//  Facory.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import Foundation

public protocol FetchAllURLUsecaseFactoryProtocol {
    func make(withStore store: CoreDataStore) -> FetchAllShortURLUseCase
}

public struct FetchAllURLUsecaseFactory: FetchAllURLUsecaseFactoryProtocol {
    public func make(withStore store: CoreDataStore) -> FetchAllShortURLUseCase {
        let context = store.container.newBackgroundContext()
        let client = CoreDataDatabaseFetchAllClient(context: context)
        return DatabaseFetchAllShortURLUseCase(databaseClient: client)
    }
}
