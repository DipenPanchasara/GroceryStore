//
//  CategoriesData.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Foundation

struct CategoriesData: Codable {
  let categories: [Category]

  struct Category: Codable, Equatable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String?
  }
}
