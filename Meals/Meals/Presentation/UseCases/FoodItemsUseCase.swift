//
//  FoodItemsUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import Foundation
import Combine

protocol FoodItemsUseCaseProtocol {
  var dataStream: PassthroughSubject<[FoodItemModel], Never> { get }
  var errorStream: PassthroughSubject<Error, Never> { get }
  func fetchFoodItems(by categoryName: String) async
}

struct FoodItemsUseCase: FoodItemsUseCaseProtocol {
  private let categoryRepository: CategoryRepositoryProtocol
  let dataStream: PassthroughSubject<[FoodItemModel], Never> = PassthroughSubject()
  let errorStream: PassthroughSubject<Error, Never> = PassthroughSubject()

  init(categoryRepository: CategoryRepositoryProtocol) {
    self.categoryRepository = categoryRepository
  }
  
  func fetchFoodItems(by categoryName: String) async {
    do {
      let foodItemModels = try await categoryRepository.fetchFoodItems(by: categoryName)
        .map({ map(foodData: $0) })
      dataStream.send(foodItemModels)
    } catch {
      errorStream.send(error)
    }
  }
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
