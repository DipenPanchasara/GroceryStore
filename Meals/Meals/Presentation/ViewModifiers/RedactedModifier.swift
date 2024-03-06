//
//  RedactedModifier.swift
//  Meals
//
//  Created by Dipen Panchasara on 06/03/2024.
//

import SwiftUI

extension View {
  @ViewBuilder
  func redacted(if condition: @autoclosure () -> Bool) -> some View {
    redacted(reason: condition() ? .placeholder : [])
  }
}
