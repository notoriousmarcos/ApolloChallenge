//
//  CoreDataShortURLDatabaseRemoveClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation
import CoreData

public class CoreDataShortURLDatabaseRemoveClient: DatabaseRemoveClient {

    public let context: NSManagedObjectContext

    public init(context: NSManagedObjectContext) {
        self.context = context
    }

    public func remove(model: ShortlyURLModel, completion: @escaping (Bool) -> Void) {
        let fetchRequest: NSFetchRequest<ShortlyURLManagedObject> = NSFetchRequest(entityName: "ShortlyURLManagedObject")
        fetchRequest.predicate = NSPredicate(format: "code == %@", model.code)

        do {
            if let shortly = try context.fetch(fetchRequest).first {
                context.delete(shortly)
                try context.save()
            }
            completion(true)
        } catch {
            completion(false)
        }
    }
}
