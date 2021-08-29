//
//  MainButton.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

struct MainButton: View {
    var text: String
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
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(text: "Copy", action: {})
    }
}
