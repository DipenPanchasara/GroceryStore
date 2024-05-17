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

  private var result: CurrentValueSubject<Result<[FoodItemModel], Error>, Never> = .init(.failure(NoStubError()))

//  private var result: Result<[FoodItemModel], Error> = .failure(NoStubError())
  var publisher: AnyPublisher<Result<[FoodItemModel], Error>, Never> {
    return result.eraseToAnyPublisher()
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
//      self.result = .failure(error)
      self.result.send(.failure(error))
      return
    }
//    self.result = .success(foodItems)
    self.result.send(.success(foodItems))
    self.result.send(completion: .finished)
  }
}
#endif
