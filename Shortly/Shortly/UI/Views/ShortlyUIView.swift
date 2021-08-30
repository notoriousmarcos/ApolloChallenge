//
//  ShortlyUIView.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

struct ShortlyUIView<Model>: View where Model: ShortlyViewModel {
    @ObservedObject var viewModel: Model
    @State private var showingAlert = false

    var body: some View {
        VStack {
            if viewModel.shortlyURLViewModels.isEmpty {
                EmptyView()
            } else {
                ShortlyListView(models: $viewModel.shortlyURLViewModels, delete: viewModel.deleteURL(_:))
            }

            ShortenLinkContainerView(isLoading: $viewModel.isGeneratingURL, createURL: viewModel.createURL(_:))
        }.onAppear(perform: {
            viewModel.onAppear()
        })
        .alert(isPresented: Binding<Bool>(
            get: { self.viewModel.alert?.isShowing ?? false },
            set: { _ in }
        )) {
            Alert(title: Text(self.viewModel.alert?.title ?? "Alert"),
                  message: Text(self.viewModel.alert?.message ?? "Unexpected"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct ShortlyUIView_Previews: PreviewProvider {
    static var previews: some View {
        ShortlyUIView(viewModel: ShortlyViewModel(
                        fetchAllURLs: { completion in
                            completion(.success([ShortlyURLModel(code: "KCveN",
                                                        shortLink: "shrtco.de/KCveN",
                                                        fullShortLink: "https://shrtco.de/KCveN",
                                                        shortLink2: "9qr.de/KCveN",
                                                        fullShortLink2: "https://9qr.de/KCveN",
                                                        shareLink: "shrtco.de/share/KCveN",
                                                        fullShareLink: "https://shrtco.de/share/KCveN",
                                                        originalLink: "http://example.org/very/long/link.html")]))
                        },
                        saveURL: { _,_  in },
                        fetchURL: { _,_  in },
                        removeURL: { _,_  in })
        )
    }
}
