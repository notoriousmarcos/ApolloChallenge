//
//  ShortlyApp.swift
//  Shortly
//
//  Created by marcos.brito on 27/08/21.
//

import SwiftUI

class Main {
    static var shared = Main()

    let coreDataStore = CoreDataStore.shared
    lazy var fetchAllUseCase = FetchAllURLUsecaseFactory().make(withStore: coreDataStore)
    lazy var fetchUseCase = FetchShortURLUseCaseFactory().make()
    lazy var saveUseCase = SaveShortURLUseCaseFactory().make(withStore: coreDataStore)
    lazy var removeUseCase = RemoveShortURLUseCaseFactory().make(withStore: coreDataStore)

    func makeShortlyViewModel() -> ShortlyViewModel {
        ShortlyViewModel(
            fetchAllURLs: fetchAllUseCase.execute,
            saveURL: saveUseCase.execute,
            fetchURL: fetchUseCase.execute,
            removeURL: removeUseCase.execute
        )
    }
}

@main
struct ShortlyApp: App {
    let main = Main.shared

    var body: some Scene {
        WindowGroup {
            ShortlyUIView(viewModel: main.makeShortlyViewModel())
                .environment(\.managedObjectContext, main.coreDataStore.container.viewContext)
        }
    }
}
