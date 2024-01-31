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
    let expectedCategories: [ViewModel.CategoriesData.Category] = [
      .init(idCategory: "a", strCategory: "abc", strCategoryThumb: "thumb"),
      .init(idCategory: "b", strCategory: "bcd", strCategoryThumb: nil)
    ]
    let vm = ViewModel(
      network: MockNetworkManager(
        object: ViewModel.CategoriesData(
          categories: expectedCategories
        )
      )
    )
    await vm.onAppear()
    XCTAssertEqual(vm.categories, expectedCategories)
  }
}
