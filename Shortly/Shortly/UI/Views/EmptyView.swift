//
//  EmptyView.swift
//  Shortly
//
//  Created by marcos.brito on 29/08/21.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack(spacing: 14) {
            Image("logo")

            Image("illustration")
            VStack(alignment: .center, spacing: 8) {
                Text("Let’s get started!")
                    .font(.title2)
                    .foregroundColor(Colors.gray300)
                Text("Paste your first link into the field to shorten it")
                    .font(.body)
                    .foregroundColor(Colors.gray300)
            }
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
