//
//  FoodItemsViewModelUnitTests.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 16/05/2024.
//

import Cuckoo
import Combine
@testable import Meals
import SwiftUI
import XCTest

final class FoodItemsViewModelUnitTests: XCTestCase {
  func testInit() {
    let subject: CurrentValueSubject<Result<[FoodItemModel], Error>, Never> = .init(.failure(MockError.useCasefailed))

    let mockUseCase = MockFoodItemsUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchFoodItems(by: any())
        .thenDoNothing()
      $0.publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }

    let sut = FoodItemsViewModel(
      categoryName: "anyName",
      useCase: mockUseCase,
      categoryRouter: MockCategoryRouterProtocol()
    )
    XCTAssertEqual(sut.loadingState, .idle)
  }
  
  func testOnAppear() {
    let subject: CurrentValueSubject<Result<[FoodItemModel], Error>, Never> = .init(.success([]))
    let mockUseCase = MockFoodItemsUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchFoodItems(by: any())
        .thenDoNothing()
      when($0).publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }
    
    let spy = PublisherSpy(mockUseCase.publisher)
    let sut = FoodItemsViewModel(
      categoryName: "anyName",
      useCase: mockUseCase,
      categoryRouter: MockCategoryRouterProtocol()
    )
    XCTAssertTrue(spy.values.isEmpty)
    sut.loadData()
    
    subject.send(.success(.mock))
    XCTAssertEqual(spy.values.count, 4)
    XCTAssertEqual(spy.callCounts, 2)
  }
  
  func testOnRetryTap() {
    let subject: CurrentValueSubject<Result<[FoodItemModel], Error>, Never> = .init(.success([]))
    let mockUseCase = MockFoodItemsUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchFoodItems(by: any())
        .thenDoNothing()
      when($0).publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }
    
    let spy = PublisherSpy(mockUseCase.publisher)
    let sut = FoodItemsViewModel(
      categoryName: "anyName",
      useCase: mockUseCase,
      categoryRouter: MockCategoryRouterProtocol()
    )
    XCTAssertTrue(spy.values.isEmpty)
    sut.onRetryTap()
    
    subject.send(.success(.mock))
    XCTAssertEqual(spy.values.count, 4)
    XCTAssertEqual(spy.callCounts, 2)
  }
}

private extension FoodItemsViewModelUnitTests {
  enum MockError: Error {
    case useCasefailed
  }
}
