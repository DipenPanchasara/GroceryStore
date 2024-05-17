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

  private var result: CurrentValueSubject<Result<[CategoryModel], Error>, Never> = .init(.failure(NoStubError()))

  var publisher: AnyPublisher<Result<[CategoryModel], Error>, Never> {
    result.eraseToAnyPublisher()
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
      self.result.send(.failure(error))
      return
    }
    self.result.send(.success(categoriesModel))
  }

  func fetchCategories() async -> Result<[CategoryModel], any Error> {
    guard let categoriesModel else {
      return .failure(error)
    }
    return .success(categoriesModel)
  }
}
#endif
