//
//  FoodData.swift
//  Meals
//
//  Created by Dipen Panchasara on 23/02/2024.
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
