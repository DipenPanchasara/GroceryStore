//
//  FoodItemsViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import Foundation
import Combine

final class FoodItemsViewModel: ObservableObject {
  struct ViewModel: Equatable {
    var foodItems: [FoodItemModel]
  }

  @Published var loadingState: LoadingState<FoodItemsViewModel.ViewModel> = .idle
  private(set) var categoryRouter: CategoryRouterProtocol
  private let useCase: FoodItemsUseCaseProtocol
  private let categoryName: String
  private var cancellables = Set<AnyCancellable>()

  var navigationTitle: String {
    categoryName
  }
  
  init(
    categoryName: String,
    useCase: FoodItemsUseCaseProtocol,
    categoryRouter: CategoryRouterProtocol
  ) {
    self.categoryName = categoryName
    self.useCase = useCase
    self.categoryRouter = categoryRouter
    self.subscribe()
  }
  
  private func subscribe() {
    useCase.dataStream
      .receive(on: DispatchQueue.main)
      .sink { [weak self] foodItems in
        self?.loadingState = .loaded(model: ViewModel(foodItems: foodItems))
      }
      .store(in: &cancellables)
    useCase.errorStream
      .receive(on: DispatchQueue.main)
      .sink { [weak self] error in
        self?.loadingState = .failed(model: ErrorModel(message: "Unable to load FoodItems."))
      }
      .store(in: &cancellables)
  }
    
  @MainActor
  func onAppear() async {
    loadingState = .loading
    await useCase.fetchFoodItems(by: categoryName)
  }
  
  func onRetryTap() async {
    await onAppear()
  }
  
  func onBackTap() {
    categoryRouter.pop()
  }
}
