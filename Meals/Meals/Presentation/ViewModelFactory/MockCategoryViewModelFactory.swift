//
//  MockCategoryViewModelFactory.swift
//  Meals
//
//  Created by Dipen Panchasara on 23/02/2024.
//

import SwiftUI

struct MockCategoryViewModelFactory: CategoryViewModelFactoryProtocol {
  private let categoryRouter = CategoryRouter(
    router: Router(path: NavigationPath())
  )
  func categoryListViewModel() -> CategoriesViewModel {
    CategoriesViewModel(
      useCase: MockCategoriesUseCase(categories: .mock),
      categoryRouter: categoryRouter,
      categoryViewModelFactory: self
    )
  }
  
  func foodItemsViewModel(categoryName: String) -> FoodItemsViewModel {
    FoodItemsViewModel(
      categoryName: "anyCategory",
      useCase: MockFoodItemsUseCase(foodItems: .mock),
      categoryRouter: categoryRouter
    )
  }
}
