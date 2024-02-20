//
//  CategoryRepository.swift
//  Meals
//
//  Created by Dipen Panchasara on 12/02/2024.
//

import Foundation

protocol CategoryRepositoryProtocol {
  func allCategories() async throws -> [CategoriesData.Category]
  func fetchFoodItems(by categoryName: String) async throws -> [FoodData.FoodItemData]
}

final class CategoryRepository: CategoryRepositoryProtocol {
  enum CategoryRepositoryError: Error {
    case noDataFound
  }

  private let networkManager: NetworkManager
  private let decoder: ResponseDecoderProvider

  init(
    networkManager: NetworkManager,
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

}
