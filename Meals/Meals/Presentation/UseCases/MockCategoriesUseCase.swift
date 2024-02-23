//
//  MockCategoriesUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//
#if DEBUG
import Foundation
import Combine

struct MockCategoriesUseCase: CategoriesUseCaseProtocol {
  struct NoStubError: Error {}
  private var categories: [CategoryModel]? = []
  private let error: Error
  let dataStream: PassthroughSubject<[CategoryModel], Never> = PassthroughSubject()
  let errorStream: PassthroughSubject<Error, Never> = PassthroughSubject()
  
  init(categories: [CategoryModel]) {
    self.categories = categories
    self.error = NoStubError()
  }
  
  init(error: Error) {
    self.error = error
    self.categories = nil
  }

  func fetchCategories() async {
    guard let categories else {
      errorStream.send(error)
      return
    }
    dataStream.send(categories)
  }
}
#endif
