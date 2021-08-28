//
//  CoreDataStore.swift
//  ShortlyTests
//
//  Created by marcos.brito on 28/08/21.
//

import Foundation
import CoreData

public class CoreDataStore {
    public static let shared = CoreDataStore()

    public enum StorageType {
        case persistent, inMemory
    }

    public let container: NSPersistentContainer

    public init(_ storageType: StorageType = .persistent) {
        container = NSPersistentContainer(name: "Shortly")

        if storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            container.persistentStoreDescriptions = [description]
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
