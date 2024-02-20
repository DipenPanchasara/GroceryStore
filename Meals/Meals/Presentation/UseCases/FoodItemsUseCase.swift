//
//  FoodItemsUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import Foundation

struct FoodData: Decodable, Equatable {
  struct FoodItemData: Decodable, Equatable {
    let strMeal: String
    let strMealThumb: String?
    let idMeal: String
  }

  let meals: [FoodItemData]
}

protocol FoodItemsUseCaseProtocol {
  func fetchFoodItems(by categoryName: String) async throws -> [FoodItemModel]
}

struct FoodItemsUseCase: FoodItemsUseCaseProtocol {
  private let categoryRepository: CategoryRepositoryProtocol
  
  init(categoryRepository: CategoryRepositoryProtocol) {
    self.categoryRepository = categoryRepository
  }
  
  func fetchFoodItems(by categoryName: String) async throws -> [FoodItemModel] {
    do {
      let foodItemsData: [FoodData.FoodItemData] = try await categoryRepository.fetchFoodItems(by: categoryName)
      return foodItemsData.map({ map(foodData: $0) })
    } catch {
      throw error
    }
  }
}

private extension FoodItemModel {
  static var mockItems: [FoodItemModel] = [
    FoodItemModel(id: "1", name: "SeaFood", thumbURL: nil),
    FoodItemModel(id: "2", name: "Dessert", thumbURL: nil),
    FoodItemModel(id: "3", name: "Pasta", thumbURL: nil),
    FoodItemModel(id: "4", name: "Starter", thumbURL: nil),
    FoodItemModel(id: "5", name: "Breakfast", thumbURL: nil)
  ]
}

private extension FoodItemsUseCase {
  func map(foodData: FoodData.FoodItemData) -> FoodItemModel {
    var thumbnailURL: URL?
    if let urlString = foodData.strMealThumb {
      thumbnailURL = URL(string: urlString)
    }
    
    return FoodItemModel(
      id: foodData.idMeal,
      name: foodData.strMeal,
      thumbURL: thumbnailURL
    )
  }
}
