//
//  CategoryViewModelFactory.swift
//  Meals
//
//  Created by Dipen Panchasara on 20/02/2024.
//

import Foundation

protocol CategoryViewModelFactoryProtocol {
  func categoryListViewModel() -> CategoriesViewModel
  func foodItemsViewModel(categoryName: String) -> FoodItemsViewModel
}

class CategoryViewModelFactory: CategoryViewModelFactoryProtocol {
  private let categoryRepository: CategoryRepositoryProtocol
  private let categoryRouter: CategoryRouterProtocol

  init(
    categoryRepository: CategoryRepositoryProtocol,
    categoryRouter: CategoryRouterProtocol
  ) {
    self.categoryRepository = categoryRepository
    self.categoryRouter = categoryRouter
  }

  func categoryListViewModel() -> CategoriesViewModel {
    CategoriesViewModel(
      useCase: CategoriesUseCase(
        categoryRepository: categoryRepository
      ),
      categoryRouter: categoryRouter,
      categoryViewModelFactory: self
    )
  }

  func foodItemsViewModel(categoryName: String) -> FoodItemsViewModel {
    FoodItemsViewModel(
      categoryName: categoryName,
      useCase: FoodItemsUseCase(categoryRepository: categoryRepository),
      categoryRouter: categoryRouter
    )
  }
}
