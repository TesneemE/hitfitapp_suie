//
//  ContainerView.swift
//  HIITFIIT
//
//  Created by Tes Essa on 10/1/24.
//

import SwiftUI

struct ContainerView<Content: View>: View {
  var content: Content

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25.0)
        .foregroundColor(Color("background"))
      VStack {
        Spacer()
        Rectangle()
          .frame(height: 25)
          .foregroundColor(Color("background"))
      }
      content
    }
  }
}

struct Container_Previews: PreviewProvider {
  static var previews: some View {
    ContainerView {
      VStack {
        RaisedButton(buttonText: "Hello World") {}
          .padding(50)
        Button("Tap me!") {}
          .buttonStyle(EmbossedButtonStyle(buttonShape: .round))
      }
    }
    .padding(50)
    .previewLayout(.sizeThatFits)
  }
}
