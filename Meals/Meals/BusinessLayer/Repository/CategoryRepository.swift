//
//  CategoryRepository.swift
//  Meals
//
//  Created by Dipen Panchasara on 12/02/2024.
//

import Combine
import Foundation

protocol CategoryRepositoryProtocol {
  func allCategories() -> AnyPublisher<[CategoryEntity], Error>
}

final class CategoryRepository: CategoryRepositoryProtocol {
  enum CategoryRepositoryError: Error {
    case noDataFound
  }

  private let networkManager: NetworkProvider
  private var subscriptions = Set<AnyCancellable>()
  private let decoder: ResponseDecoderProvider = ResponseDecoder()

  init(networkManager: NetworkProvider) {
    self.networkManager = networkManager
  }

  func allCategories() -> AnyPublisher<[CategoryEntity], Error> {
    networkManager.execute(
      networkRequest: NetworkRequest(
        httpMethod: .get,
        endpoint: .allCategories
      )
    )
    .tryMap {
      try $0.decode()
    }
    .map({
      (result: CategoriesData) in
      result.categories.map {
        CategoryEntity(
          id: $0.idCategory,
          name: $0.strCategory,
          thumbURLString: $0.strCategoryThumb
        )
      }
    })
    .eraseToAnyPublisher()
  }
}


// MARK : - CategoryEntity
struct CategoryEntity: Equatable {
  let id: String
  let name: String
  let thumbURLString: String?
}
