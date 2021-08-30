//
//  ShortenLinkContainerView.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

struct ShortenLinkContainerView: View {
    @State private var inputState: InputTextField.InputState = .idle(placeholder: "Shorten a link here ...")
    @State private var url: String = ""
    @Binding var isLoading: Bool
    var createURL: (String) -> Void
    
    var body: some View {
        HStack{
            VStack(alignment: .center, spacing: 10) {
                InputTextField(state: $inputState, text: $url, isDisabled: $isLoading)
                MainButton(text: .constant("shorten it!"), isLoading: $isLoading) {
                    guard !url.isEmpty else {
                        inputState = .wrong(placeholder: "Please add a link here")
                        return
                    }
                    inputState = .idle(placeholder: "Shorten a link here ...")
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
