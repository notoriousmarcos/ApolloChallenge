//
//  Facory.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import Foundation

public protocol RemoveShortURLUseCaseFactoryProtocol {
    func make(withStore store: CoreDataStore) -> RemoveShortURLUseCase
}

public struct RemoveShortURLUseCaseFactory: RemoveShortURLUseCaseFactoryProtocol {
    public func make(withStore store: CoreDataStore) -> RemoveShortURLUseCase {
        let context = store.container.newBackgroundContext()
        let client = CoreDataShortURLDatabaseRemoveClient(context: context)
        return DatabaseRemoveShortURLUseCase(databaseClient: client)
    }
}
