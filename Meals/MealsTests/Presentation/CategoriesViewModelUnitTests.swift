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
    let mockUseCase = MockCategoriesUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchCategories()
        .thenReturn(.failure(MockError.useCasefailed))
    }
    let sut = CategoriesViewModel(
      useCase: mockUseCase,
      categoryRouter: MockCategoryRouterProtocol(),
      categoryViewModelFactory: MockCategoryViewModelFactoryProtocol()
    )
    XCTAssertEqual(sut.loadingState, .idle)
  }
  
  func testViewModel_whenOnAppearCalled() async throws {
    let expectedCategories: [CategoryModel] = .mock
    let mockUseCase = MockCategoriesUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchCategories()
        .thenReturn(.success(expectedCategories))
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
    let mockUseCase = MockCategoriesUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchCategories()
        .thenReturn(.failure(MockError.useCasefailed))
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
    let expectedCategories: [CategoryModel] = .mock
    let mockUseCase = MockCategoriesUseCaseProtocol()
    stub(mockUseCase) {
      $0.fetchCategories()
        .thenReturn(.success(expectedCategories))
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
}

private extension CategoriesViewModelUnitTests {
  enum MockError: Error {
    case useCasefailed
  }
}

