//
//  MainButton.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

struct MainButton: View {
    @Binding var text: String
    @Binding var isDisabled: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text(text.uppercased())
                    .font(.title2)
                    .bold()
                    .padding()
                    .foregroundColor(Color.white)
                Spacer()
            }
            .background(Colors.primary)
            .cornerRadius(4)
        })
        .disabled(isDisabled)
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(text: .constant("Copy"), isDisabled: .constant(false), action: {})
    }
}
