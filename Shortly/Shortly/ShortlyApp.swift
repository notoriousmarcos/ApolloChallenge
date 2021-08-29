//
//  ShortlyApp.swift
//  Shortly
//
//  Created by marcos.brito on 27/08/21.
//

import SwiftUI

@main
struct ShortlyApp: App {
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
