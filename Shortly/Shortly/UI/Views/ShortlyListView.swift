//
//  ShortlyListView.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

struct ShortlyListView: View {
    @State var models: [ShortlyURLViewModel] = []
    var delete: (ShortlyURLViewModel) -> Void

    var body: some View {
        List(models, id: \.code) { model in
            ShortlyViewCell(model: model, delete: delete)
        }
    }
}

struct ShortlyListView_Previews: PreviewProvider {
    static var previews: some View {
        ShortlyListView(models: [ShortlyURLViewModel(code: "Code", shortLink: "Short", originalLink: "original")], delete: { _ in})
    }
}
