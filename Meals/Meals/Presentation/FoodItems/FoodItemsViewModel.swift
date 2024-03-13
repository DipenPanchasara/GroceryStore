//
//  FoodItemsViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import SwiftUI
import Combine

final class FoodItemsViewModel: ObservableObject {
  struct ViewModel: Equatable {
    var foodItems: [FoodItemModel]
  }

  @Published var loadingState: ViewState<FoodItemsViewModel.ViewModel> = .idle
  private let categoryRouter: CategoryRouterProtocol
  private let useCase: FoodItemsUseCaseProtocol
  private let categoryName: String
  private var subscriptions = Set<AnyCancellable>()

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
    useCase.publisher
      .receive(on: DispatchQueue.main)
      .sink { completion in
        print(completion)
        switch completion {
          case .finished:
            print("\(#function) FoodItem stream finished")
          case .failure(let error):
            print("Error: \(error)")
        }
      } receiveValue: { [weak self] result in
        guard let self = self else { return }
        switch result {
          case .success(let foodItems):
            self.loadingState = .loaded(model: ViewModel(foodItems: foodItems))
          case .failure(let error):
            print("Error: \(error)")
            self.loadingState = .failed(model: ErrorModel(message: "Unable to load FoodItems."))
        }
      }
      .store(in: &subscriptions)
  }

  func loadData() {
    guard loadingState.canReload else { return }
    loadingState = .loading(model: ViewModel(foodItems: .mock))
    useCase.fetchFoodItems(by: categoryName)
  }

  func onRetryTap() {
    loadData()
  }
  
  func onFoodItemTap(item: FoodItemModel) {
    print(item)
  }
}

extension FoodItemsViewModel {
  var padding: CGFloat { 8 }
  var noOfColumns: Int  { 1 }
  var totalPadding: CGFloat {
    if noOfColumns == 1 {
      return padding * 2
    } else {
      return padding * (CGFloat(noOfColumns) + 1)
    }
  }
  
  var availableWidth: CGFloat {
    (UIScreen.main.bounds.width - totalPadding)
  }
  
  var itemWidth: CGFloat {
    availableWidth/CGFloat(noOfColumns)
  }
  
  func gridColumns() -> [GridItem] {
    [GridItem].init(repeating: GridItem(.fixed(itemWidth)), count: noOfColumns)
  }
}
