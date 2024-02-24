//
//  ErrorView.swift
//  Meals
//
//  Created by Dipen Panchasara on 09/02/2024.
//

import SwiftUI

struct ErrorView: View {
  let viewModel: ErrorModel
  let retryHandler: (() async -> Void)?

  var body: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        Text(viewModel.message)
          .font(.headline)
          .fontWeight(.bold)
          .foregroundStyle(.black)
        Spacer()
      }
      Button("Retry", action: {
        Task {
          await retryHandler?()
        }
      })
      .bold()
      .foregroundColor(.white)
      .padding(8)
      .background(
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .stroke(.white, lineWidth: 1)
          .fill(.pink)
      )
      Spacer()
    }
  }
}

struct ErrorModel: Equatable {
  static func == (lhs: ErrorModel, rhs: ErrorModel) -> Bool {
    lhs.message == rhs.message
  }

  let id: UUID = UUID()
  let message: String
}
