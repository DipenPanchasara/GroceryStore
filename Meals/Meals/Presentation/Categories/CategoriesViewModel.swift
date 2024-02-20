//
//  CategoriesViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Foundation
import SwiftUI

class CategoriesViewModel: ObservableObject {
  struct ViewModel: Equatable {
    var categories: [CategoryModel]
  }
  
  private let useCase: CategoriesUseCaseProtocol
  private(set) var categoryRouter: CategoryRouterProtocol
  private(set) var categoryViewModelFactory: CategoryViewModelFactoryProtocol
  @Published var loadingState: LoadingState<ViewModel> = .idle

  init(
    useCase: CategoriesUseCaseProtocol,
    categoryRouter: CategoryRouterProtocol,
    categoryViewModelFactory: CategoryViewModelFactoryProtocol
  ) {
    self.useCase = useCase
    self.categoryRouter = categoryRouter
    self.categoryViewModelFactory = categoryViewModelFactory
  }
  
  @MainActor
  func onAppear() async {
     loadingState = .loading
    do {
      let categories = try await useCase.fetchCategories()
      loadingState = .loaded(model: ViewModel(categories: categories))
    } catch {
      loadingState = .failed(model: ErrorModel(message: "Unable to load categories."))
    }
  }
  
  func onRetryTap() async {
    await onAppear()
  }

  @MainActor
  func onSelect(category: CategoryModel) {
    categoryRouter.push(
      destination: .foodItems(categoryName: category.name)
    )
  }
}
