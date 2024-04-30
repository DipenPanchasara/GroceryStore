//
//  BackgroundColorModifier.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/03/2024.
//

import SwiftUI

struct BackgroundColorModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .background(.gray.opacity(0.2))
  }
}

extension View {
  func backgroundColor() -> some View {
    modifier(BackgroundColorModifier())
  }
}
