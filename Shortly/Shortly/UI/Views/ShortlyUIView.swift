//
//  ShortlyUIView.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

struct ShortlyUIView<Model>: View where Model: ShortlyViewModelProtocol {
    @ObservedObject var viewModel: Model

    var body: some View {
        VStack {
            if viewModel.shortlyURLViewModels.isEmpty {
                EmptyView()
            } else {
                ShortlyListView(models: viewModel.shortlyURLViewModels, delete: viewModel.deleteURL(_:))
            }

            ShortenLinkContainerView(createURL: viewModel.createURL(_:))
        }.onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

struct ShortlyUIView_Previews: PreviewProvider {
    static var previews: some View {
        ShortlyUIView(viewModel: ShortlyViewModel(
                        fetchAllURLs: { completion in
                            completion([ShortlyURLModel(code: "KCveN",
                                                        shortLink: "shrtco.de/KCveN",
                                                        fullShortLink: "https://shrtco.de/KCveN",
                                                        shortLink2: "9qr.de/KCveN",
                                                        fullShortLink2: "https://9qr.de/KCveN",
                                                        shareLink: "shrtco.de/share/KCveN",
                                                        fullShareLink: "https://shrtco.de/share/KCveN",
                                                        originalLink: "http://example.org/very/long/link.html")])
                        },
                        saveURL: { _,_  in },
                        fetchURL: { _,_  in },
                        removeURL: { _,_  in })
        )
    }
}
