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
  private let categoryRepository: CategoryRepositoryProtocol
  
  init(categoryRepository: CategoryRepositoryProtocol) {
    self.categoryRepository = categoryRepository
  }
  
  func fetchCategories() async throws -> [CategoryModel] {
    do {
      let categories = try await categoryRepository.allCategories()
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
