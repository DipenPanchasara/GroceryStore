//
//  FoodItemRepository.swift
//  Meals
//
//  Created by Dipen Panchasara on 12/03/2024.
//

import Foundation
import Combine

protocol FoodItemRepositoryProtocol {
  func fetchFoodItems(
    by categoryName: String
  ) -> AnyPublisher<[FoodItemEntity], Error>
}

final class FoodItemRepository: FoodItemRepositoryProtocol {
  enum CategoryRepositoryError: Error {
    case noDataFound
  }
  
  private let networkManager: NetworkProvider
  private var subscriptions = Set<AnyCancellable>()
  private let decoder: ResponseDecoderProvider = ResponseDecoder()

  init(networkManager: NetworkProvider) {
    self.networkManager = networkManager
  }
  
  func fetchFoodItems(
    by categoryName: String
  ) -> AnyPublisher<[FoodItemEntity], Error> {
    networkManager.executeWithCache(
      networkRequest: NetworkRequest(
        httpMethod: .get,
        endpoint: .foodItemsByCategory(categoryName: categoryName)
      )
    )
    .tryMap {
      try $0.decode()
    }
    .map { (result: FoodData) in
      result.meals.map {
        FoodItemEntity(
          id: $0.idMeal,
          name: $0.strMeal,
          thumbURLString: $0.strMealThumb
        )
      }
    }
    .eraseToAnyPublisher()
  }
}

// MARK : - FoodItemEntity

struct FoodItemEntity: Equatable {
  let id: String
  let name: String
  let thumbURLString: String?
}
