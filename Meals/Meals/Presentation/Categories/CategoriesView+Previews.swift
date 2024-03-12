//
//  CategoriesView+Previews.swift
//  Meals
//
//  Created by Dipen Panchasara on 06/03/2024.
//


#if DEBUG
import SwiftUI

extension CategoriesView_Previews {
  private enum MockError: Error {
    case failed
  }
  
  private static let categoryRouter = CategoryRouter(router: Router(path: NavigationPath()))
  
  static var previewViews: some View {
    Group {
      NavigationStack {
        CategoriesView(
          viewModel: CategoriesViewModel(
            useCase: MockCategoriesUseCase(
              categories: .mock
            ),
            categoryRouter: categoryRouter,
            categoryViewModelFactory: MockCategoryViewModelFactory()
          )
        )
        .preferredColorScheme(.dark)
        .previewDisplayName("Success")
      }
      NavigationStack {
        CategoriesView(
          viewModel: CategoriesViewModel(
            useCase: MockCategoriesUseCase(
              error: MockError.failed
            ),
            categoryRouter: categoryRouter,
            categoryViewModelFactory: MockCategoryViewModelFactory()
          )
        )
        .preferredColorScheme(.dark)
        .previewDisplayName("Failure")
      }
    }
  }
}
#endif
