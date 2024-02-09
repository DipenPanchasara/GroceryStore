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
      Group {
        switch viewModel.loadingState {
          case .idle:
            EmptyView()
          case .loading:
            loadingView()
          case .loaded(let viewModel):
            list(categories: viewModel.categories)
          case .failed(let errorModel):
            ErrorView(viewModel: errorModel) {
              Task {
                await viewModel.onRetryTap()
              }
            }
        }
      }
      .task {
        await viewModel.onAppear()
      }
      .background(Color.white)
      .listStyle(.plain)
      .navigationBarTitle(
        "Categories",
        displayMode: .inline
      )
      .navigationBarTitleDisplayMode(.inline)
      .toolbarColorScheme(
        .dark,
        for: .navigationBar
      )
      .toolbarBackground(
        Color.pink,
        for: .navigationBar
      )
      .toolbarBackground(
        .visible,
        for: .navigationBar
      )
    }
  }
  
  private func loadingView() -> some View {
    HStack {
      ProgressView()
    }
  }

  private func list(categories: [CategoryModel]) -> some View {
    List(categories,
         rowContent: {
      categoryModel in
      CategoryCard(
        categoryModel: categoryModel
      )
      .listRowBackground(Color.clear)
      .listRowSeparator(.hidden)
    })
  }
}

#if DEBUG
struct CategoriesView_Previews: PreviewProvider {
  enum MockError: Error {
    case failed
  }

  static let viewModel = CategoriesViewModel(
    useCase: MockCategoriesUseCase(
      categories: .mock
    )
  )

  static let failedViewModel = CategoriesViewModel(
    useCase: MockCategoriesUseCase(
      error: MockError.failed
    )
  )
  
  static var previews: some View {
    Group {
      CategoriesView(viewModel: viewModel)
        .task {
          await viewModel.onAppear()
        }
        .preferredColorScheme(.dark)
        .previewDisplayName("Categories_Success")
      CategoriesView(viewModel: failedViewModel)
        .task {
          await failedViewModel.onAppear()
        }
        .preferredColorScheme(.dark)
        .previewDisplayName("Categories_failed")
    }
  }
}
#endif
