//
//  ShortenLinkContainerView.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

struct ShortenLinkContainerView: View {
    @State private var url: String = ""
    @Binding var isLoading: Bool
    var createURL: (String) -> Void
    
    var body: some View {
        HStack{
            VStack(alignment: .center, spacing: 10) {
                TextField("Shorten a link here ...", text: $url)
                    .padding(20)
                    .background(Colors.white)
                    .disabled(isLoading)
                MainButton(text: .constant("shorten it!"), isDisabled: $isLoading) {
                    createURL(url)
                    url = ""
                }

            }
        }
        .padding(50)
        .background(Colors.secundary)
    }
}

struct ShortenLinkContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ShortenLinkContainerView(isLoading: .constant(false), createURL: { _ in})
            .previewLayout(.sizeThatFits)
    }
}
