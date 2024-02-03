//
//  NetworkManagerUnitTests.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 03/02/2024.
//

@testable import Meals
import XCTest

final class NetworkManagerUnitTests: XCTestCase {
  func testNetwork() async throws {
    let networkManager = MockNetworkManager(object: CategoriesData.Category(idCategory: "idCategory", strCategory: "strCategory", strCategoryThumb: "strCategoryThumb"))
    
    let result: CategoriesData.Category = try await networkManager.execute(request: URLRequest(url: URL(string: "https://www.meals.com")!))
    XCTAssertEqual(result.idCategory, "idCategory")
  }
}
