//
//  ToolbarStyleModifier.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import SwiftUI

struct ToolbarStyleModifier: ViewModifier {
  @Environment(\.dismiss) private var dismiss
  
  let color: Color
  let showBackButton: Bool

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
      .navigationBarBackButtonHidden()
      .toolbar {
        if showBackButton {
          ToolbarItem(placement: .topBarLeading) {
            Button("", systemImage: "arrow.left.circle") {
              dismiss()
            }
          }
        }
      }
  }
}

extension View {
  func toolBarStyle(
    color: Color = .pink,
    showBackButton: Bool = false
  ) -> some View {
    modifier(
      ToolbarStyleModifier(
        color: color,
        showBackButton: showBackButton
      )
    )
  }
}
