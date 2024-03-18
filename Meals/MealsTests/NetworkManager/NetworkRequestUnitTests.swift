//
//  NetworkRequestUnitTests.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 18/03/2024.
//

import XCTest
@testable import Meals

final class NetworkRequestUnitTests: XCTestCase {
  func testInit_whenAllInputs() throws {
    let mockHeaders = ["anyKey": "anyValue"]
    let mockBodyData = try XCTUnwrap("someData".data(using: .utf8))
    let sut = NetworkRequest(
      httpMethod: .get,
      endpoint: .allCategories,
      headers: mockHeaders,
      data: mockBodyData
    )
    XCTAssertEqual(sut.httpMethod, .get)
    XCTAssertEqual(sut.endpoint, .allCategories)
    XCTAssertEqual(sut.headers, mockHeaders)
    XCTAssertEqual(sut.data, mockBodyData)
  }
  
  func testInit_whenOptionalInputsNil() {
    let sut = NetworkRequest(
      httpMethod: .get,
      endpoint: .allCategories
    )
    XCTAssertEqual(sut.httpMethod, .get)
    XCTAssertEqual(sut.endpoint, .allCategories)
    XCTAssertNil(sut.headers)
    XCTAssertNil(sut.data)
  }
}
