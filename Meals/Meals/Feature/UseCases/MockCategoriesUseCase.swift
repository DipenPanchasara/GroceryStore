//
//  MockCategoriesUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//
#if DEBUG
import Foundation

struct MockCategoriesUseCase: CategoriesUseCaseProtocol {
  struct NoStubError: Error {}
  private var categories: [CategoryModel]? = []
  private let error: Error
  
  init(categories: [CategoryModel]) {
    self.categories = categories
    self.error = NoStubError()
  }
  
  init(error: Error) {
    self.error = error
    self.categories = nil
  }
  
  func fetchCategories() async throws -> [CategoryModel] {
    guard let categories else { throw error }
    return categories
  }
}
#endif
