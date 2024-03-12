//
//  MockCategoriesUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//
#if DEBUG
import Foundation
import Combine

final class MockCategoriesUseCase: CategoriesUseCaseProtocol {
  struct NoStubError: Error {}
  private var categoriesModel: [CategoryModel]? = []
  private let error: Error

  @Published
  private var result: Result<[CategoryModel], Error> = .failure(NoStubError())
  var publisher: Published<Result<[CategoryModel], Error>>.Publisher {
    $result
  }

  init(categories: [CategoryModel]) {
    self.categoriesModel = categories
    self.error = NoStubError()
  }

  init(error: Error) {
    self.error = error
    self.categoriesModel = nil
  }

  func fetchCategories() {
    guard let categoriesModel else {
      self.result = .failure(error)
      return
    }
    self.result = .success(categoriesModel)
  }
}
#endif
