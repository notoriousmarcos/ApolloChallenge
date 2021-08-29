//
//  ShortlyViewModel.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

public protocol ShortlyViewModelProtocol: ObservableObject {
    typealias RemoveAction = (ShortlyURLModel, (Bool) -> Void) -> Void
    typealias SaveAction = (ShortlyURLModel, (Bool) -> Void) -> Void
    typealias FetchAction = (FetchShortURLUseCaseModel, (ShortlyURLModel) -> Void) -> Void
    typealias FetchAllAction = (([ShortlyURLModel]) -> Void) -> Void

    var shortlyURLViewModels: [ShortlyURLViewModel] { get }
    var isGeneratingURL: Bool { get }

    func onAppear()
    func createURL(_ urlString: String)
    func deleteURL(_ model: ShortlyURLViewModel)
}

class ShortlyViewModel: ShortlyViewModelProtocol {

    @Published public var shortlyURLViewModels: [ShortlyURLViewModel] = []
    @Published public var isGeneratingURL: Bool = false

    private var shortURLs: [ShortlyURLModel] = []
    private var fetchAllURLs: FetchAllAction
    private var saveURL: SaveAction
    private var fetchURL: FetchAction
    private var removeURL: RemoveAction

    public init(fetchAllURLs: @escaping FetchAllAction,
         saveURL: @escaping SaveAction,
         fetchURL: @escaping FetchAction,
         removeURL: @escaping RemoveAction) {
        self.fetchAllURLs = fetchAllURLs
        self.saveURL = saveURL
        self.fetchURL = fetchURL
        self.removeURL = removeURL
    }

    public func onAppear() {
        self.getAllURLs()
    }

    public func createURL(_ urlString: String) {
        isGeneratingURL = true
        let model = FetchShortURLUseCaseModel(url: urlString)
        fetchURL(model) { [weak self] url in
            self?.saveURL(url) { [weak self] success in
                if success {
                    self?.getAllURLs()
                    isGeneratingURL = false
                }
            }
        }
    }

    public func deleteURL(_ viewModel: ShortlyURLViewModel) {
        guard let model = shortURLs.first(where: { $0.code == viewModel.code }) else {
            return
        }
        removeURL(model) { [weak self] success in
            if success {
                self?.getAllURLs()
            }
        }
    }

    private func getAllURLs() {
        self.fetchAllURLs { [weak self] urls in
            self?.shortURLs = urls
            self?.shortlyURLViewModels = urls.compactMap {
                ShortlyURLViewModel(code: $0.code,
                                    shortLink: $0.shortLink,
                                    originalLink: $0.originalLink)
            }
        }
    }
}
