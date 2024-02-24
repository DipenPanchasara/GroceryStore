//
//  CategoriesViewModelUnitTests.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 29/01/2024.
//

@testable import Meals
import XCTest

final class CategoriesViewModelUnitTests: XCTestCase {
  func testViewModel_whenInit() async throws {
    let vm = CategoriesViewModel(
      useCase: MockCategoriesUseCase(
        error: MockError.useCasefailed
      )
    )
    XCTAssertEqual(vm.loadingState, .idle)
  }

  func testViewModel_whenOnAppearCalled() async throws {
    let expectedCategories: [CategoryModel] = .mock
    let vm = CategoriesViewModel(
      useCase: MockCategoriesUseCase(categories: expectedCategories)
    )
    await vm.onAppear()
    XCTAssertEqual(
      vm.loadingState,
      .loaded(
        model: CategoriesViewModel.ViewModel(categories: .mock)
      )
    )
  }

  func testViewModel_whenUseCaseThrows() async throws {
    let vm = CategoriesViewModel(
      useCase: MockCategoriesUseCase(error: MockError.useCasefailed)
    )
    await vm.onAppear()
    XCTAssertEqual(
      vm.loadingState,
      .failed(model: ErrorModel(message: "Unable to load categories."))
    )
  }

  func testViewModel_whenOnRetryTap() async throws {
    let expectedCategories: [CategoryModel] = .mock
    let vm = CategoriesViewModel(
      useCase: MockCategoriesUseCase(categories: expectedCategories)
    )
    await vm.onRetryTap()
    XCTAssertEqual(
      vm.loadingState,
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
