//
//  FoodItemsView+Previews.swift
//  Meals
//
//  Created by Dipen Panchasara on 06/03/2024.
//


#if DEBUG
import SwiftUI

extension FoodItemsView_Previews {
  enum MockError: Error {
    case failed
  }
  
  private static let categoryRouter = CategoryRouter(router: Router(path: NavigationPath()))
  
  static var previewViews: some View {
    Group {
      NavigationStack {
        FoodItemsView(
          viewModel: FoodItemsViewModel(
            categoryName: "Vegetarian",
            useCase: MockFoodItemsUseCase(foodItems: .mock),
            categoryRouter: categoryRouter
          )
        )
        .preferredColorScheme(.dark)
        .previewDisplayName("Success")
      }
      NavigationStack {
        FoodItemsView(
          viewModel: FoodItemsViewModel(
            categoryName: "Vegetarian",
            useCase: MockFoodItemsUseCase(error: MockError.failed),
            categoryRouter: categoryRouter
          )
        )
        .preferredColorScheme(.dark)
        .previewDisplayName("Failure")
      }
    }
  }
}
#endif
