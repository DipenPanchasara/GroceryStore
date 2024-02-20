//
//  FoodItemsViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import Foundation

struct FoodItemModel: Identifiable, Equatable, Hashable {
  let id: String
  let name: String
  let thumbURL: URL?
}

final class FoodItemsViewModel: ObservableObject {  
  struct ViewModel: Equatable {
    var foodItems: [FoodItemModel]
  }

  @Published var loadingState: LoadingState<FoodItemsViewModel.ViewModel> = .idle
  private(set) var categoryRouter: CategoryRouterProtocol
  private let useCase: FoodItemsUseCaseProtocol
  private let categoryName: String

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
  }
    
  @MainActor
  func onAppear() async {
    loadingState = .loading
    do {
      let foodItems = try await useCase.fetchFoodItems(by: categoryName)
      loadingState = .loaded(model: ViewModel(foodItems: foodItems))
    } catch {
      loadingState = .failed(model: ErrorModel(message: "Unable to load FoodItems."))
    }
  }
  
  func onRetryTap() async {
    await onAppear()
  }
}
