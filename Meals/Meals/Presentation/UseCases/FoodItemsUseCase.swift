//
//  FoodItemsUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import Combine
import SwiftUI

protocol FoodItemsUseCaseProtocol {
  var publisher: Published<Result<[FoodItemModel], Error>>.Publisher { get }

  func fetchFoodItems(by categoryName: String)
}

final class FoodItemsUseCase: FoodItemsUseCaseProtocol {
  enum UseCaseError: Error {
    case initialState
    case noData
  }

  private let foodItemRepository: FoodItemRepositoryProtocol
  private var subscriptions = Set<AnyCancellable>()

  @Published
  private var result: Result<[FoodItemModel], Error> = .failure(UseCaseError.initialState)
  var publisher: Published<Result<[FoodItemModel], Error>>.Publisher {
    return $result
  }

  init(foodItemRepository: FoodItemRepositoryProtocol) {
    self.foodItemRepository = foodItemRepository
  }
  
  func fetchFoodItems(by categoryName: String) {
    foodItemRepository.fetchFoodItems(by: categoryName)
      .map { categoryEntities in
        categoryEntities.map { self.map(foodItemEntity: $0) }
      }
      .sink { completion in
        switch completion {
          case .finished:
            print("\(#function) FoodItem stream finished")
          case .failure(let error):
            self.result = .failure(error)
        }
      } receiveValue: { categories in
        self.result = .success(categories)
      }
      .store(in: &subscriptions)
  }

}

private extension FoodItemsUseCase {
  func map(foodItemEntity: FoodItemEntity) -> FoodItemModel {
    var thumbnailURL: URL?
    if let urlString = foodItemEntity.thumbURLString {
      thumbnailURL = URL(string: urlString)
    }

    return FoodItemModel(
      id: foodItemEntity.id,
      name: foodItemEntity.name,
      thumbURL: thumbnailURL
    )
  }
}
