//
//  CategoriesViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Foundation
import SwiftUI
import Combine

class CategoriesViewModel: ObservableObject {
  struct ViewModel: Equatable {
    var categories: [CategoryModel]
  }
  
  private let useCase: CategoriesUseCaseProtocol
  private(set) var categoryRouter: CategoryRouterProtocol
  private(set) var categoryViewModelFactory: CategoryViewModelFactoryProtocol
  @Published var loadingState: LoadingState<ViewModel> = .idle
  private var cancellables = Set<AnyCancellable>()
  
  init(
    useCase: CategoriesUseCaseProtocol,
    categoryRouter: CategoryRouterProtocol,
    categoryViewModelFactory: CategoryViewModelFactoryProtocol
  ) {
    self.useCase = useCase
    self.categoryRouter = categoryRouter
    self.categoryViewModelFactory = categoryViewModelFactory
    self.subscribe()
  }

  private func subscribe() {
    loadingState = .loading
    useCase.dataStream
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] categories in
        self?.loadingState = .loaded(model: ViewModel(categories: categories))
      })
      .store(in: &cancellables)
    useCase.errorStream
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] error in
        print("error: \(error)")
        self?.loadingState = .failed(model: ErrorModel(message: "Unable to load categories."))
        
      })
      .store(in: &cancellables)
  }
  
  @MainActor
  func onAppear() async {
    await useCase.fetchCategories()
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
