//
//  TextClassifier.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/17.
//

import Foundation
import SwiftUI

struct ScanTag: UIViewRepresentable {
  @Binding var text: String
let button = UIButton()
  func makeUIView(context: Context) -> UIButton {
    let textFromCamera = UIAction.captureTextFromCamera(
      responder: context.coordinator,
      identifier: nil)
      
      UIView.animate(withDuration: 0.6,
          animations: {
              self.button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
          },
          completion: { _ in
              UIView.animate(withDuration: 0.6) {
                  self.button.transform = CGAffineTransform.identity
              }
          })
      
    button.setImage(
        UIImage(named: "TagScan")?.resizeTo(size: CGSize(width: getScreenBounds().width/15, height: getScreenBounds().width/15)),
        for: .normal)
    
    button.menu = UIMenu(children: [textFromCamera])
    return button
  }

  func updateUIView(_ uiView: UIButton, context: Context) { }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: UIResponder, UIKeyInput {
    let parent: ScanTag
    init(_ parent: ScanTag) { self.parent = parent }

    var hasText = false
    func insertText(_ text: String) {
      parent.text = text

    }
    func deleteBackward() { }
  }
}

struct ScanButton_Previews: PreviewProvider {
  static var previews: some View {
      ScanTag(text: .constant(""))
      .previewLayout(.sizeThatFits)
  }
}

