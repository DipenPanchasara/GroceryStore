//
//  CategoriesUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Combine
import SwiftUI

protocol CategoriesUseCaseProtocol {
  var publisher: AnyPublisher<Result<[CategoryModel], Error>, Never> { get }

  func fetchCategories()
  func fetchCategories() async -> Result<[CategoryModel], Error>
}

final class CategoriesUseCase: CategoriesUseCaseProtocol {
  enum UseCaseError: Error {
    case initialState
    case noData
  }

  private let categoryRepository: CategoryRepositoryProtocol
  private var subscriptions = Set<AnyCancellable>()
  
  private var result: CurrentValueSubject<Result<[CategoryModel], Error>, Never> = .init(.failure(UseCaseError.initialState))
  var publisher: AnyPublisher<Result<[CategoryModel], Error>, Never> {
    return result.eraseToAnyPublisher()
  }

  init(categoryRepository: CategoryRepositoryProtocol) {
    self.categoryRepository = categoryRepository
  }

  func fetchCategories() {
    categoryRepository.allCategories()
      .map { categoryEntities in
        categoryEntities.map { self.map(categoryEntity: $0) }
      }
      .sink { [weak self] completion in
        switch completion {
          case .finished:
            print("\(#function) Category stream finished")
          case .failure(let error):
            self?.result.send(.failure(error))
        }
      } receiveValue: { [weak self] categories in
        self?.result.send(.success(categories))
      }
      .store(in: &subscriptions)
  }
  
  func fetchCategories() async -> Result<[CategoryModel], Error> {
    let result = categoryRepository.allCategories().values
    do {
      for try await catetoryEntities in result {
        let models = catetoryEntities.map {
          self.map(categoryEntity: $0)
        }
        return .success(models)
      }
    } catch {
      return .failure(error)
    }
    return .failure(UseCaseError.noData)
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
