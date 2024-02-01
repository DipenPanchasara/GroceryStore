//
//  CategoriesData.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Foundation

struct CategoriesData: Decodable {
  let categories: [Category]
  
  struct Category: Decodable, Equatable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String?
  }
}
