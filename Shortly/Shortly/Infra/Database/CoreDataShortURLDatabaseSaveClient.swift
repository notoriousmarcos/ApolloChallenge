//
//  CoreDataShortURLDatabaseSaveClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation
import CoreData

public class CoreDataShortURLDatabaseSaveClient: DatabaseSaveClient {

    public let context: NSManagedObjectContext

    public init(context: NSManagedObjectContext) {
        self.context = context
    }

    public func save(model: ShortlyURLModel, completion: @escaping (Bool) -> Void) {
        let shortlyURL = ShortlyURLManagedObject(context: context)
        shortlyURL.setupWithShortlyModel(model)
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
}
