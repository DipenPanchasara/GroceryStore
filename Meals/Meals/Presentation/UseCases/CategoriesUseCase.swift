//
//  CategoriesUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Combine
import SwiftUI

protocol CategoriesUseCaseProtocol {
  var publisher: Published<Result<[CategoryModel], Error>>.Publisher { get }

  func fetchCategories()
}

final class CategoriesUseCase: CategoriesUseCaseProtocol {
  enum UseCaseError: Error {
    case initialState
    case noData
  }

  private let categoryRepository: CategoryRepositoryProtocol
  private var subscriptions = Set<AnyCancellable>()
  
  @Published
  private var result: Result<[CategoryModel], Error> = .failure(UseCaseError.initialState)
  var publisher: Published<Result<[CategoryModel], Error>>.Publisher {
    return $result
  }

  init(categoryRepository: CategoryRepositoryProtocol) {
    self.categoryRepository = categoryRepository
  }
    
  func fetchCategories() {
    categoryRepository.allCategories()
      .map { categoryEntities in
        categoryEntities.map { self.map(categoryEntity: $0) }
      }
      .sink { completion in
        switch completion {
          case .finished:
            print("\(#function) Category stream finished")
          case .failure(let error):
            self.result = .failure(error)
        }
      } receiveValue: { categories in
        self.result = .success(categories)
      }
      .store(in: &subscriptions)
  }
}

private extension CategoriesUseCase {
  func map(categoryEntity: CategoryEntity) -> CategoryModel {
    var thumbnailURL: URL?
    if let urlString = categoryEntity.thumbURLString {
      thumbnailURL = URL(string: urlString)
    }
    
    return CategoryModel(
      id: categoryEntity.id,
      name: categoryEntity.name,
      thumbnailURL: thumbnailURL
    )
  }
}
