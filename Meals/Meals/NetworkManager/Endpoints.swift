//
//  Endpoints.swift
//  Meals
//
//  Created by Dipen Panchasara on 12/02/2024.
//

import Foundation

enum Endpoints: Equatable {
  case allCategories
  case foodItemsByCategory(categoryName: String)
  
  var path: String {
    switch self {
      case .allCategories:
        "categories.php"
      case .foodItemsByCategory:
        "filter.php"
    }
  }
  
  var queryItems: [String: String]? {
    switch self {
      case .allCategories:
        nil
      case .foodItemsByCategory(let categoryName):
        ["c" : categoryName]
    }
  }
}
