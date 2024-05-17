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
    XCTAssertEqual(sut.navigationTitle, "anyName")
    XCTAssertEqual(sut.loadingState, .idle)
  }
  
  func testSubscribeReceivesSuccess() async {
    let expectation = expectation(description: "wait for all states")
    let subject: PassthroughSubject<Result<[FoodItemModel], Error>, Never> = PassthroughSubject()
    let mockUseCase = MockFoodItemsUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchFoodItems(by: equal(to: "anyName"))
        .thenDoNothing()
      when($0).publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }
    
    let sut = FoodItemsViewModel(
      categoryName: "anyName",
      useCase: mockUseCase,
      categoryRouter: MockCategoryRouterProtocol()
    )
    let mocks = Self.mock
    let state = sut.$loadingState
    let spy = PublisherSpy(publisher: state.eraseToAnyPublisher()) { values in
      if values.count == 3 {
        XCTAssertEqual(values, [
          .idle,
          .loading(model: FoodItemsViewModel.ViewModel(foodItems: .mock)),
          .loaded(model: FoodItemsViewModel.ViewModel(foodItems: mocks))
        ])
        expectation.fulfill()
      }
    }
    XCTAssertEqual(spy.values, [.idle])
    sut.loadData()
    subject.send(.success(mocks))
    subject.send(completion: .finished)

    await fulfillment(of: [expectation], timeout: 0.1)
  }
  
  func testSubscribeReceivesError() async {
    let expectation = expectation(description: "wait for all states")
    let subject: PassthroughSubject<Result<[FoodItemModel], Error>, Never> = PassthroughSubject()
    let mockUseCase = MockFoodItemsUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchFoodItems(by: equal(to: "anyName"))
        .thenDoNothing()
      when($0).publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }
    
    let sut = FoodItemsViewModel(
      categoryName: "anyName",
      useCase: mockUseCase,
      categoryRouter: MockCategoryRouterProtocol()
    )
    let state = sut.$loadingState
    let spy = PublisherSpy(publisher: state.eraseToAnyPublisher()) { values in
      if values.count == 2 {
        XCTAssertEqual(values, [
          .idle,
          .failed(model: ErrorModel(message: "Unable to load FoodItems."))
        ])
        expectation.fulfill()
      }
    }
    XCTAssertEqual(spy.values, [.idle])
    subject.send(.failure(MockError.useCasefailed))
    
    await fulfillment(of: [expectation], timeout: 0.1)
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
  
  func testOnFoodItemTap() throws {
    let subject: CurrentValueSubject<Result<[FoodItemModel], Error>, Never> = .init(.failure(MockError.useCasefailed))
    let mockUseCase = MockFoodItemsUseCaseProtocol()
    stub(mockUseCase) {
      when($0).publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }
    let router = MockRouter()
    let sut = FoodItemsViewModel(
      categoryName: "anyName",
      useCase: mockUseCase,
      categoryRouter: router
    )
    let mockItemModel = FoodItemModel(id: UUID().uuidString, name: "Vegetarian", thumbURL: nil)
    sut.onFoodItemTap(item: mockItemModel)
    XCTAssertEqual(router.values.count, 1)
    let destination = try XCTUnwrap(router.values.first as? CategoryRoutes)
    XCTAssertEqual(destination, Meals.CategoryRoutes.foodDetail(item: mockItemModel))
  }
}

// MARK: - Mocks

private extension FoodItemsViewModelUnitTests {
  enum MockError: Error {
    case useCasefailed
  }
  
  static var mock: [FoodItemModel] {
    [FoodItemModel].init(repeating: FoodItemModel(id: UUID().uuidString, name: "Vegetarian", thumbURL: nil), count: 2)
  }
}

private final class MockRouter: CategoryRouterProtocol {
  var router: any Meals.RouterProtocol = MockRouterProtocol()
  private(set) var values: [any Hashable] = []

  func push(destination: Meals.CategoryRoutes) {
    values.append(destination)
  }
  
  func pop() {
    values.append("pop")
  }
  
  func popToRootView() {
    values.append("popToRootView")
  }
}
