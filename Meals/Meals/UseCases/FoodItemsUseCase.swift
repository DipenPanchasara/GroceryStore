//
//  FoodItemsUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import Combine
import SwiftUI

protocol FoodItemsUseCaseProtocol {
  var publisher: AnyPublisher<Result<[FoodItemModel], Error>, Never> { get }

  func fetchFoodItems(by categoryName: String)
  func fetchFoodItems(by categoryName: String) async -> Result<[FoodItemModel], Error>
}

final class FoodItemsUseCase: FoodItemsUseCaseProtocol {
  enum UseCaseError: Error {
    case initialState
    case noData
  }

  private let foodItemRepository: FoodItemRepositoryProtocol
  private var subscriptions = Set<AnyCancellable>()

  @Published
  private var result: CurrentValueSubject<Result<[FoodItemModel], Error>, Never> = .init(.failure(UseCaseError.initialState))
  var publisher: AnyPublisher<Result<[FoodItemModel], Error>, Never> {
    return result.eraseToAnyPublisher()
  }

  init(foodItemRepository: FoodItemRepositoryProtocol) {
    self.foodItemRepository = foodItemRepository
  }
  
  func fetchFoodItems(by categoryName: String) {
    foodItemRepository.fetchFoodItems(by: categoryName)
      .map { categoryEntities in
        categoryEntities.map { self.map(foodItemEntity: $0) }
      }
      .sink { [weak self] completion in
        switch completion {
          case .finished:
            print("\(#function) FoodItem stream finished")
          case .failure(let error):
            self?.result.send(.failure(error))
        }
      } receiveValue: { [weak self] categories in
        self?.result.send(.success(categories))
        self?.result.send(completion: .finished)
      }
      .store(in: &subscriptions)
  }

  func fetchFoodItems(by categoryName: String) async -> Result<[FoodItemModel], Error> {
    let result = foodItemRepository.fetchFoodItems(by: categoryName).values
    do {
      for try await foodItemsEntities in result {
        let models = foodItemsEntities.map {
          self.map(foodItemEntity: $0)
        }
        return .success(models)
      }
    } catch {
      return .failure(error)
    }
    return .failure(UseCaseError.noData)
  }
}

private extension FoodItemsUseCase {
  func map(foodItemEntity: FoodItemEntity) -> FoodItemModel {
    var thumbnailURL: URL?
    if let urlString = foodItemEntity.thumbURLString {
      thumbnailURL = URL(string: urlString)
    }

    return FoodItemModel(
      id: foodItemEntity.id,
      name: foodItemEntity.name,
      thumbURL: thumbnailURL
    )
  }
}
