//
//  MockFoodItemsUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 23/02/2024.
//

#if DEBUG
import Combine
import SwiftUI

final class MockFoodItemsUseCase: FoodItemsUseCaseProtocol {
  struct NoStubError: Error {}
  private var foodItems: [FoodItemModel]? = []
  private let error: Error

  @Published
  private var result: Result<[FoodItemModel], Error> = .failure(NoStubError())
  var publisher: Published<Result<[FoodItemModel], Error>>.Publisher {
    return $result
  }

  init(foodItems: [FoodItemModel]) {
    self.foodItems = foodItems
    self.error = NoStubError()
  }

  init(error: Error) {
    self.error = error
    self.foodItems = nil
  }

  func fetchFoodItems(by categoryName: String) {
    guard let foodItems else {
      self.result = .failure(error)
      return
    }
    self.result = .success(foodItems)
  }
}
#endif
