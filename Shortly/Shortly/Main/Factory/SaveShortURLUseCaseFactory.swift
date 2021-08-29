//
//  Facory.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import Foundation

public protocol SaveShortURLUseCaseFactoryProtocol {
    func make(withStore store: CoreDataStore) -> SaveShortURLUseCase
}

public struct SaveShortURLUseCaseFactory: SaveShortURLUseCaseFactoryProtocol {
    public func make(withStore store: CoreDataStore) -> SaveShortURLUseCase {
        let context = store.container.newBackgroundContext()
        let client = CoreDataShortURLDatabaseSaveClient(context: context)
        return DatabaseSaveShortURLUseCase(databaseClient: client)
    }
}
