//
//  CategoryRepository.swift
//  Meals
//
//  Created by Dipen Panchasara on 12/02/2024.
//

import Combine
import Foundation

protocol CategoryRepositoryProtocol {
  func allCategories() -> AnyPublisher<[CategoryEntity], Error>
  func allCategories() async throws -> [CategoriesData.Category]
  func fetchFoodItems(by categoryName: String) async throws -> [FoodData.FoodItemData]
}

final class CategoryRepository: CategoryRepositoryProtocol {
  enum CategoryRepositoryError: Error {
    case noDataFound
  }

  private let networkManager: NetworkProvider
  private let decoder: ResponseDecoderProvider
  private var subscriptions = Set<AnyCancellable>()

  init(
    networkManager: NetworkProvider,
    decoder: ResponseDecoderProvider
  ) {
    self.networkManager = networkManager
    self.decoder = decoder
  }

  func allCategories() async throws -> [CategoriesData.Category] {
    do {
      let response = try await networkManager.execute(
        request: NetworkRequest(
          httpMethod: .get,
          endpoint: .allCategories
        )
      )
      guard
        let data = response.data
      else {
        throw CategoryRepositoryError.noDataFound
      }

      // Decode Response
      let categoriesData: CategoriesData = try decoder.decode(CategoriesData.self, from: data)
      return categoriesData.categories
    } catch {
      throw error
    }
  }

  func fetchFoodItems(by categoryName: String) async throws -> [FoodData.FoodItemData] {
    do {
      let response = try await networkManager.execute(
        request: NetworkRequest(
          httpMethod: .get,
          endpoint: .foodItemsByCategory(categoryName: categoryName)
        )
      )
      guard
        let data = response.data
      else {
        throw CategoryRepositoryError.noDataFound
      }

      // Decode Response
      let foodData: FoodData = try decoder.decode(FoodData.self, from: data)
      return foodData.meals
    } catch {
      throw error
    }
  }
  
  func allCategories() -> AnyPublisher<[CategoryEntity], Error> {
    networkManager.execute(
      networkRequest: NetworkRequest(
        httpMethod: .get,
        endpoint: .allCategories
      )
    )
    .map({
      (result: CategoriesData) in
      result.categories.map {
        CategoryEntity(
          id: $0.idCategory,
          name: $0.strCategory,
          thumbURLString: $0.strCategoryThumb
        )
      }
    })
    .eraseToAnyPublisher()
  }
}

struct CategoryEntity: Equatable {
  let id: String
  let name: String
  let thumbURLString: String?
}
