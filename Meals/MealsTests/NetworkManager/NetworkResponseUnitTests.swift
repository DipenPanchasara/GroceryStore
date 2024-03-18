//
//  NetworkResponseUnitTests.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 18/03/2024.
//

import XCTest
@testable import Meals

final class NetworkResponseUnitTests: XCTestCase {
  func testInit_whenDataAvailable() throws {
    let mockData = try XCTUnwrap("someData".data(using: .utf8))
    let baseURL = try XCTUnwrap(URL(string: "www.test.com"))
    let mockHTTPResponse = try XCTUnwrap(HTTPURLResponse(
      url: XCTUnwrap(baseURL),
      statusCode: 200,
      httpVersion: "testVersion",
      headerFields: nil
    ))
    let sut = NetworkResponse(data: mockData, urlResponse: mockHTTPResponse)
    XCTAssertEqual(sut.data, mockData)
    XCTAssertEqual(sut.urlResponse, mockHTTPResponse)
  }
  
  func testInit_whenDataNotAvailable() throws {
    let baseURL = try XCTUnwrap(URL(string: "www.test.com"))
    let mockHTTPResponse = try XCTUnwrap(HTTPURLResponse(
      url: XCTUnwrap(baseURL),
      statusCode: 400,
      httpVersion: "testVersion",
      headerFields: nil
    ))
    let sut = NetworkResponse(data: nil, urlResponse: mockHTTPResponse)
    XCTAssertNil(sut.data)
    XCTAssertEqual(sut.urlResponse, mockHTTPResponse)
  }
  
  func testNetworkResponse_whenDecodingSuccess() throws {
    let baseURL = try XCTUnwrap(URL(string: "www.test.com"))
    let mockHTTPResponse = try XCTUnwrap(HTTPURLResponse(
      url: XCTUnwrap(baseURL),
      statusCode: 200,
      httpVersion: "testVersion",
      headerFields: nil
    ))
    let object = [
      "id": "anyId",
      "name": "anyName"
    ]
    let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
    let sut = NetworkResponse(data: data, urlResponse: mockHTTPResponse)
    XCTAssertNotNil(sut.data)
    XCTAssertEqual(sut.urlResponse, mockHTTPResponse)
    let result: MockDecodable = try sut.decode()
    XCTAssertEqual(result.id, "anyId")
    XCTAssertEqual(result.name, "anyName")
  }
  
  func testNetworkResponse_whenDecodingThrowsKeyNotFound() throws {
    let baseURL = try XCTUnwrap(URL(string: "www.test.com"))
    let mockHTTPResponse = try XCTUnwrap(HTTPURLResponse(
      url: XCTUnwrap(baseURL),
      statusCode: 200,
      httpVersion: "testVersion",
      headerFields: nil
    ))
    let object = [
      "id": "anyId",
      "wrong_key": "anyName"
    ]
    let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
    let sut = NetworkResponse(data: data, urlResponse: mockHTTPResponse)
    XCTAssertNotNil(sut.data)
    XCTAssertEqual(sut.urlResponse, mockHTTPResponse)
    do {
      let _: MockDecodable = try sut.decode()
    } catch {
      guard let decodingError = error as? ResponseDecoder.DecoderError else {
        XCTFail("Expected to throw ResponseDecoder.DecoderError.")
        return
      }
      if case .decodingFailed(let reason) = decodingError {
          XCTAssertNotNil(reason)
      }
    }
  }
}

extension NetworkResponseUnitTests {
  struct MockDecodable: Decodable {
    let id: String
    let name: String
  }
}
