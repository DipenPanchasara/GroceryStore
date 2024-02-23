//
//  MockFoodItemsUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 23/02/2024.
//

#if DEBUG
import Foundation
import Combine

struct MockFoodItemsUseCase: FoodItemsUseCaseProtocol {
  struct NoStubError: Error {}
  private var foodItems: [FoodItemModel]? = []
  private let error: Error
  let dataStream: PassthroughSubject<[FoodItemModel], Never> = PassthroughSubject()
  let errorStream: PassthroughSubject<Error, Never> = PassthroughSubject()

  init(foodItems: [FoodItemModel]) {
    self.foodItems = foodItems
    self.error = NoStubError()
  }
  
  init(error: Error) {
    self.error = error
    self.foodItems = nil
  }

  func fetchFoodItems(by categoryName: String) async {
    guard let foodItems else {
      errorStream.send(error)
      return
    }
    dataStream.send(foodItems)
  }
}
#endif
