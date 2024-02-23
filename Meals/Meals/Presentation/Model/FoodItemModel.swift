//
//  FoodItemModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 23/02/2024.
//

import Foundation

struct FoodItemModel: Identifiable, Equatable, Hashable {
  let id: String
  let name: String
  let thumbURL: URL?
}

// MARK: - Mock Models for preview
#if DEBUG
extension [FoodItemModel] {
  static let mock: [FoodItemModel] = [
    FoodItemModel(id: UUID().uuidString, name: "Vegetarian", thumbURL: nil),
    FoodItemModel(id: UUID().uuidString, name: "Vegan", thumbURL: nil),
    FoodItemModel(id: UUID().uuidString, name: "Asian", thumbURL: nil),
    FoodItemModel(id: UUID().uuidString, name: "Chinese", thumbURL: nil),
  ]
}
#endif
