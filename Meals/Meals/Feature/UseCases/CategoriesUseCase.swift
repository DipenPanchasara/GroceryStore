//
//  CategoriesUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Foundation

protocol CategoriesUseCaseProtocol {
  func fetchCategories() async throws -> [CategoryModel]
}

struct CategoriesUseCase: CategoriesUseCaseProtocol {
  private let networkManager: NetworkManager
  
  init(networkManager: NetworkManager) {
    self.networkManager = networkManager
  }
  
  func fetchCategories() async throws -> [CategoryModel] {
    do {
      let categoriesData: CategoriesData = try await networkManager.execute(request: URLRequest(url: URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!))
      let categories = categoriesData.categories
      return categories.map({ map(categoryData: $0) }).sorted(by: { $0.name < $1.name })
    } catch {
      throw error
    }
  }
}

private extension CategoriesUseCase {
  func map(categoryData: CategoriesData.Category) -> CategoryModel {
    var thumbnailURL: URL?
    if let urlString = categoryData.strCategoryThumb {
      thumbnailURL = URL(string: urlString)
    }
    
    return CategoryModel(
      id: categoryData.idCategory,
      name: categoryData.strCategory,
      thumbnailURL: thumbnailURL
    )
  }
}
