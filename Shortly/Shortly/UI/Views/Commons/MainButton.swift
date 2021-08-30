//
//  MainButton.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

struct MainButton: View {
    @Binding var text: String
    @Binding var isLoading: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action, label: {
            HStack(alignment: .center) {
                Spacer()
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Colors.white))
                        .scaleEffect(1)
                        .padding()
                } else {
                    Text(text.uppercased())
                        .font(.title2)
                        .bold()
                        .padding()
                        .foregroundColor(Color.white)
                }
                Spacer()
            }
            .frame(minHeight: 50, idealHeight: 50, maxHeight: 50)
            .background(Colors.primary)
            .cornerRadius(4)
        })
        .disabled(isLoading)
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(text: .constant("Copy"), isLoading: .constant(false), action: {})
    }
}
