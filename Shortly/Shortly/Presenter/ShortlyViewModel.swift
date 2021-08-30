//
//  ShortlyViewModel.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

public struct AlertInfo {
    public let title: String
    public let message: String
    public let isShowing: Bool
}

public protocol ShortlyViewModelProtocol: ObservableObject {
    typealias RemoveAction = (ShortlyURLModel, @escaping (Bool) -> Void) -> Void
    typealias SaveAction = (ShortlyURLModel, @escaping (Bool) -> Void) -> Void
    typealias FetchAction = (FetchShortURLUseCaseModel, @escaping (Result<ShortlyURLModel, FetchShortURLError>) -> Void) -> Void
    typealias FetchAllAction = (@escaping (Result<[ShortlyURLModel], FetchAllShortURLError>) -> Void) -> Void

    var shortlyURLViewModels: [ShortlyURLViewModel] { get }
    var isGeneratingURL: Bool { get }
    var alert: AlertInfo? { get }

    func onAppear()
    func createURL(_ urlString: String)
    func deleteURL(_ model: ShortlyURLViewModel)
}

class ShortlyViewModel: ShortlyViewModelProtocol {

    @Published public var shortlyURLViewModels: [ShortlyURLViewModel] = []
    @Published public var isGeneratingURL: Bool = false
    @Published public var alert: AlertInfo?

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
        fetchURL(model) { [weak self] result in
            switch result{
                case .success(let url):
                    self?.saveURL(url) { [weak self] success in
                        if success {
                            self?.getAllURLs()
                            self?.isGeneratingURL = false
                        }
                    }
                case .failure(let error):
                    self?.alert = AlertInfo(title: "Alert", message: error.localizedDescription, isShowing: true)
                    print(error.localizedDescription)
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
        self.fetchAllURLs { [weak self] result in
            switch result {
                case .success(let urls):
                    self?.shortURLs = urls
                    self?.shortlyURLViewModels = urls.compactMap {
                        ShortlyURLViewModel(code: $0.code,
                                            shortLink: $0.shortLink,
                                            originalLink: $0.originalLink)
                    }
                case .failure(let error):
                    self?.alert = AlertInfo(title: "Alert", message: error.localizedDescription, isShowing: true)
            }

        }
    }
}
