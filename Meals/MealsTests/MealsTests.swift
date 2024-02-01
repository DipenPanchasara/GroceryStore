//
//  MealsTests.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 29/01/2024.
//

@testable import Meals
import XCTest

final class MealsTests: XCTestCase {
  
  func testViewModel_whenOnAppearCalled() async throws {
    let expectedCategories: [CategoryModel] = .mock
    let vm = CategoriesViewModel(
      useCase: MockCategoriesUseCase(categories: expectedCategories)
    )
    await vm.onAppear()
    XCTAssertEqual(vm.categories, expectedCategories)
  }
}
