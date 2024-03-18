//
//  EndpointsUnitTests.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 18/03/2024.
//

import XCTest
@testable import Meals

final class EndpointsUnitTests: XCTestCase {
  func testEndpointsPath() {
    let inputOutput: [Endpoints: String] = [
      .allCategories: "categories.php",
      .foodItemsByCategory(categoryName: "someValue"): "filter.php"
    ]

    for object in inputOutput {
      XCTAssertEqual(object.key.path, object.value)
    }
  }
  
  func testEndpointsQueryItems() {
    let inputOutput: [Endpoints: [String: String]?] = [
      .allCategories: nil,
      .foodItemsByCategory(categoryName: "someValue"): ["c": "someValue"]
    ]
    
    for object in inputOutput {
      XCTAssertEqual(object.key.queryItems, object.value)
    }
  }
}
