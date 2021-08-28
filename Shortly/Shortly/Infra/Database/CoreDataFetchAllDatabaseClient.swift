//
//  CoreDataFetchAllDatabaseClient.swift
//  Shortly
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation
import CoreData

public class CoreDataFetchAllDatabaseClient: DatabaseFetchAllClient {

    public let context: NSManagedObjectContext

    public init(context: NSManagedObjectContext) {
        self.context = context
    }

    public func fetchAll(completion: @escaping (DatabaseFetchAllClient.Result) -> Void) {
        let fetchRequest: NSFetchRequest<ShortlyURLManagedObject> = NSFetchRequest(entityName: "ShortlyURLManagedObject")
        do {
            let result: [ShortlyURLManagedObject] = try context.fetch(fetchRequest)
            let urls = result.compactMap { $0.toShortlyURLModel() }
            completion(.success(urls))

        } catch {
            completion(.failure(.unknown))
        }
    }
}
