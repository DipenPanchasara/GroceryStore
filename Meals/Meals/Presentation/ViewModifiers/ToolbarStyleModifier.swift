//
//  ToolbarStyleModifier.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import SwiftUI

struct ToolbarStyleModifier: ViewModifier {
  let color: Color
  func body(content: Content) -> some View {
    content
      .toolbarColorScheme(
        .dark,
        for: .navigationBar
      )
      .toolbarBackground(
        color,
        for: .navigationBar
      )
      .toolbarBackground(
        .visible,
        for: .navigationBar
      )
  }
}

extension View {
  func toolBarStyle(color: Color = .pink) -> some View {
    modifier(ToolbarStyleModifier(color: color))
  }
}
