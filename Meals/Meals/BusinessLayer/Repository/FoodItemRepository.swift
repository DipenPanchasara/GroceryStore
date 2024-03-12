//
//  FoodItemRepository.swift
//  Meals
//
//  Created by Dipen Panchasara on 12/03/2024.
//

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
  
  init(networkManager: NetworkProvider) {
    self.networkManager = networkManager
  }
  
  func fetchFoodItems(
    by categoryName: String
  ) -> AnyPublisher<[FoodItemEntity], Error> {
    networkManager.execute(
      networkRequest: NetworkRequest(
        httpMethod: .get,
        endpoint: .foodItemsByCategory(categoryName: categoryName)
      )
    )
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

//    do {
//      let response = try await networkManager.execute(
//        request: NetworkRequest(
//          httpMethod: .get,
//          endpoint: .foodItemsByCategory(categoryName: categoryName)
//        )
//      )
//      guard
//        let data = response.data
//      else {
//        throw CategoryRepositoryError.noDataFound
//      }
      
      // Decode Response
//      let foodData: FoodData = try decoder.decode(FoodData.self, from: data)
//      return foodData.meals
//    } catch {
//      throw error
//    }
  }
}

struct FoodItemEntity: Equatable {
  let id: String
  let name: String
  let thumbURLString: String?
}
