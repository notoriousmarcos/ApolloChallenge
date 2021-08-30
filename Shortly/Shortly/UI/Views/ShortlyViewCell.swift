//
//  ShortlyViewCell.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

struct ShortlyViewCell: View {
    var model: ShortlyURLViewModel
    var delete: (ShortlyURLViewModel) -> Void

    private func HeaderView() -> some View {
        return HStack(spacing: 10) {
            Text(model.originalLink)
                .font(.title2)
                .foregroundColor(Colors.gray300)
            Spacer()
            Button(action: {
                delete(model)
            }, label: {
                Image("del")
                    .foregroundColor(Colors.gray300)
            })
        }
    }

    var body: some View {
        return VStack(alignment: .leading) {
            HeaderView()
                .padding(.horizontal, 23)
            Divider().background(Colors.gray100)
            Text(model.shortLink)
                .font(.title2)
                .foregroundColor(Colors.primary)
                .padding(.horizontal, 23)
            MainButton(text: .constant("Copy"), isLoading: .constant(false)) {
                UIPasteboard.general.string = model.shortLink
            }
            .padding(.all, 23)
        }.cornerRadius(8)
    }
}

struct ShortlyViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ShortlyViewCell(model: ShortlyURLViewModel(code: "Code",
                                                   shortLink: "shortlink",
                                                   originalLink: "original link")) { _ in }
            .previewLayout(.sizeThatFits)
    }
}
