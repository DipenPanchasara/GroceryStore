//
//  CategoriesViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Foundation

class CategoriesViewModel: ObservableObject {
  struct ViewModel: Equatable {
    var categories: [CategoryModel]
  }
  
  private let useCase: CategoriesUseCaseProtocol
  @Published var loadingState: LoadingState<ViewModel> = .idle
  
  init(useCase: CategoriesUseCaseProtocol) {
    self.useCase = useCase
  }
  
  @MainActor
  func onAppear() async {
    loadingState = .loading
    do {
      let categories = try await useCase.fetchCategories()
      loadingState = .loaded(model: ViewModel(categories: categories))
    } catch {
      loadingState = .failed("Unable to load categories.")
    }
  }
}
