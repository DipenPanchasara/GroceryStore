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
  private(set) var router: CategoryRouter
  @Published var loadingState: LoadingState<ViewModel> = .idle

  init(useCase: CategoriesUseCaseProtocol, router: CategoryRouter) {
    self.useCase = useCase
    self.router = router
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
    router.push(destination: .categoryItems(model: category))
  }
}
