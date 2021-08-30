//
//  MainButton.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

struct InputTextField: View {
    enum InputState {
        case idle(placeholder: String)
        case wrong(placeholder: String)

        var placeholder: String {
            switch self {
                case .idle(let placeholder):
                    return placeholder
                case .wrong(let placeholder):
                    return placeholder
            }
        }
    }

    @Binding var state: InputState
    @Binding var text: String
    @Binding var isDisabled: Bool

    var body: some View {
        if case .idle = state {
            Input()
        } else {
            Input()
                .foregroundColor(Color.red)
                .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.red, lineWidth: 1)
            )
        }
    }

    func Input() -> some View {
        TextField(state.placeholder, text: $text)
            .multilineTextAlignment(.center)
            .padding()
            .frame(minHeight: 50, idealHeight: 50, maxHeight: 50)
            .background(Colors.white)
            .disabled(isDisabled)
    }
}

struct InputTextField_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField( state: .constant(.idle(placeholder: "")), text: .constant(""), isDisabled: .constant(false))
    }
}
