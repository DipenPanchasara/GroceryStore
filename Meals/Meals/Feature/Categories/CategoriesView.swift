//
//  Categories.swift
//  Meals
//
//  Created by Dipen Panchasara on 29/01/2024.
//

import SwiftUI

struct CategoriesView: View {
  @ObservedObject var viewModel: CategoriesViewModel
    var body: some View {
      NavigationStack {
        List(viewModel.categories, rowContent: { categoryModel in
          VStack(spacing: .zero) {
            HStack {
              Image(uiImage: .add)
                .frame(width: 24, height: 24)
                .background(Color.gray)
                .mask({
                  Circle()
                    .cornerRadius(16)
                })
              Text(categoryModel.name)
                .font(.title)
            }
          }
          .listRowSeparator(.hidden)
          .padding()
          .cornerRadius(10)
        })
        .listStyle(.plain)
        .navigationTitle("Categories")
        .navigationBarTitleDisplayMode(.inline)
        .task {
          await viewModel.onAppear()
        }
      }
    }
}

#if DEBUG
#Preview {
  CategoriesView(
    viewModel: CategoriesViewModel(
      useCase: MockCategoriesUseCase(
        categories: .mock
      )
    )
  )
}

#endif
