//
//  CategoriesViewModelUnitTests.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 29/01/2024.
//

@testable import Meals
import Cuckoo
import Combine
import XCTest

final class CategoriesViewModelUnitTests: XCTestCase {
  func testViewModel_whenInit() async throws {
    let subject: PassthroughSubject<Result<[CategoryModel], Error>, Never> = PassthroughSubject()
    let mockUseCase = MockCategoriesUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchCategories()
        .thenReturn(.failure(MockError.useCasefailed))
      when($0).publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }
    let sut = CategoriesViewModel(
      useCase: mockUseCase,
      categoryRouter: MockCategoryRouterProtocol(),
      categoryViewModelFactory: MockCategoryViewModelFactoryProtocol()
    )
    XCTAssertEqual(sut.loadingState, .idle)
  }
  
  func testViewModel_whenSubscribeReceivesSuccess() async {
    let expectation = expectation(description: "wait for all states")
    let subject: PassthroughSubject<Result<[CategoryModel], Error>, Never> = PassthroughSubject()
    let mockUseCase = MockCategoriesUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchCategories()
        .thenDoNothing()
      when($0).publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }
    
    let sut = CategoriesViewModel(
      useCase: mockUseCase,
      categoryRouter: MockCategoryRouterProtocol(),
      categoryViewModelFactory: MockCategoryViewModelFactoryProtocol()
    )
    let mocks = Self.mock
    let state = sut.$loadingState
    let spy = PublisherSpy(publisher: state.eraseToAnyPublisher()) { values in
      if values.count == 3 {
        XCTAssertEqual(values, [
          .idle,
          .loading(model: CategoriesViewModel.ViewModel(categories: .mock)),
          .loaded(model: CategoriesViewModel.ViewModel(categories: mocks))
        ])
        expectation.fulfill()
      }
    }
    XCTAssertEqual(spy.values, [.idle])
    sut.loadData()
    subject.send(.success(mocks))
    subject.send(completion: .finished)
    
    await fulfillment(of: [expectation], timeout: 0.2)
  }

  func testViewModel_whenSubscribeReceivesError() async {
    let expectation = expectation(description: "wait for all states")
    let subject: PassthroughSubject<Result<[CategoryModel], Error>, Never> = PassthroughSubject()
    let mockUseCase = MockCategoriesUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchCategories()
        .thenDoNothing()
      when($0).publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }
    
    let sut = CategoriesViewModel(
      useCase: mockUseCase,
      categoryRouter: MockCategoryRouterProtocol(),
      categoryViewModelFactory: MockCategoryViewModelFactoryProtocol()
    )
    let state = sut.$loadingState
    let spy = PublisherSpy(publisher: state.eraseToAnyPublisher()) { values in
      if values.count == 2 {
        expectation.fulfill()
      }
    }
    XCTAssertEqual(spy.values, [.idle])
    subject.send(.failure(MockError.useCasefailed))
    
    await fulfillment(of: [expectation], timeout: 0.1)
  }
  
  func testViewModel_whenOnAppearCalled() async throws {
    let subject: PassthroughSubject<Result<[CategoryModel], Error>, Never> = PassthroughSubject()
    let expectedCategories: [CategoryModel] = .mock
    let mockUseCase = MockCategoriesUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchCategories()
        .thenReturn(.success(expectedCategories))
      when($0).publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }
    
    let sut = CategoriesViewModel(
      useCase: mockUseCase,
      categoryRouter: MockCategoryRouterProtocol(),
      categoryViewModelFactory: MockCategoryViewModelFactoryProtocol()
    )
    await sut.fetchData()
    XCTAssertEqual(
      sut.loadingState,
      .loaded(
        model: CategoriesViewModel.ViewModel(categories: .mock)
      )
    )
  }

  func testViewModel_whenUseCaseThrows() async throws {
    let subject: PassthroughSubject<Result<[CategoryModel], Error>, Never> = PassthroughSubject()
    let mockUseCase = MockCategoriesUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchCategories()
        .thenReturn(.failure(MockError.useCasefailed))
      when($0).publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }
    let sut = CategoriesViewModel(
      useCase: mockUseCase,
      categoryRouter: MockCategoryRouterProtocol(),
      categoryViewModelFactory: MockCategoryViewModelFactoryProtocol()
    )
    await sut.fetchData()
    XCTAssertEqual(
      sut.loadingState,
      .failed(model: ErrorModel(message: "Unable to load categories."))
    )
  }

  func testViewModel_whenOnRetryTap() async throws {
    let subject: PassthroughSubject<Result<[CategoryModel], Error>, Never> = PassthroughSubject()
    let expectedCategories: [CategoryModel] = .mock
    let mockUseCase = MockCategoriesUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchCategories()
        .thenReturn(.success(expectedCategories))
      when($0).publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }

    let sut = CategoriesViewModel(
      useCase: mockUseCase,
      categoryRouter: MockCategoryRouterProtocol(),
      categoryViewModelFactory: MockCategoryViewModelFactoryProtocol()
    )
    await sut.onRetryTap()
    XCTAssertEqual(
      sut.loadingState,
      .loaded(
        model: CategoriesViewModel.ViewModel(categories: .mock)
      )
    )
  }
  
  @MainActor 
  func testViewModel_whenOnFoodItemTap() throws {
    let subject: CurrentValueSubject<Result<[CategoryModel], Error>, Never> = .init(.failure(MockError.useCasefailed))
    let mockUseCase = MockCategoriesUseCaseProtocol()
    stub(mockUseCase) {
      when($0).publisher.get
        .thenReturn(subject.eraseToAnyPublisher())
    }
    let router = MockCategoryRouter()
    let sut = CategoriesViewModel(
      useCase: mockUseCase,
      categoryRouter: router,
      categoryViewModelFactory: CategoryViewModelFactory(
        categoryRepository: MockCategoryRepositoryProtocol(),
        foodItemRepository: MockFoodItemRepositoryProtocol(),
        categoryRouter: MockCategoryRouterProtocol()
      )
    )
    let mockItemModel = CategoryModel(id: UUID().uuidString, name: "anyName", thumbnailURL: nil)
    sut.onSelect(category: mockItemModel)
    XCTAssertEqual(router.values.count, 1)
    let destination = try XCTUnwrap(router.values.first as? CategoryRoutes)
    XCTAssertEqual(destination, Meals.CategoryRoutes.foodItems(categoryName: "anyName"))
  }
}

private extension CategoriesViewModelUnitTests {
  enum MockError: Error {
    case useCasefailed
  }
  
  static var mock: [CategoryModel] {
    [CategoryModel].init(repeating: CategoryModel(id: UUID().uuidString, name: "Vegetarian", thumbnailURL: nil), count: 2)
  }
}

