//
//  CategoryModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Foundation

struct CategoryModel: Identifiable, Equatable, Hashable {
  let id: String
  let name: String
  let thumbnailURL: URL?
}

// MARK: - Mock Models for preview
#if DEBUG
extension [CategoryModel] {
  static let mock: [CategoryModel] = [
    CategoryModel(id: UUID().uuidString, name: "Vegetarian", thumbnailURL: nil),
    CategoryModel(id: UUID().uuidString, name: "Vegan", thumbnailURL: nil),
    CategoryModel(id: UUID().uuidString, name: "Asian", thumbnailURL: nil),
    CategoryModel(id: UUID().uuidString, name: "Chinese", thumbnailURL: nil)
  ]
}
#endif
