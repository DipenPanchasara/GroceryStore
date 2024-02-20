//
//  NetworkManagerUnitTests.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 03/02/2024.
//

@testable import Meals
import XCTest
import Combine

final class NetworkManagerUnitTests: XCTestCase {
  private let baseURLString = "www.test.com"
  private var baseURL: URL?

  override func setUp() async throws {
    try await super.setUp()
    self.baseURL = try XCTUnwrap(URL(string: baseURLString))
  }

  override func tearDown() async throws {
    self.baseURL = nil
    try await super.tearDown()
  }

  func testNetworkRequestSuccess() async throws {
    let obj = CategoriesData.Category(idCategory: "idCategory", strCategory: "strCategory", strCategoryThumb: "strCategoryThumb")
    let data: Data = try JSONEncoder().encode(obj)
    let sut = try NetworkManager(
      scheme: "https",
      baseURLString: baseURLString,
      session: MockNetworkSession(
        baseURL: XCTUnwrap(baseURL),
        data: data,
        response: HTTPURLResponse(
          url: XCTUnwrap(baseURL),
          statusCode: 200,
          httpVersion: "testVersion",
          headerFields: nil
        )
      )
    ) 
    
    let response: NetworkResponse = try await sut.execute(
      request: NetworkRequest(
        httpMethod: .get,
        endpoint: .allCategories
      )
    )
    XCTAssertEqual(response.urlResponse.statusCode, 200)
    XCTAssertNotNil(response.data)
  }
  
  func testNetworkRequest_whenThrowsBadURL() async throws {
    let sut = try NetworkManager(
      scheme: "https",
      baseURLString: "https://www.test.com",
      session: MockNetworkSession(
        baseURL: XCTUnwrap(baseURL),
        data: Data(),
        response: HTTPURLResponse(
          url: XCTUnwrap(baseURL),
          statusCode: 200,
          httpVersion: "testVersion",
          headerFields: nil
        )
      )
    )
    let expectation = expectation(description: "Wait for NetworkError error.")
    do {
      let _: NetworkResponse = try await sut.execute(
        request: NetworkRequest(
          httpMethod: .get,
          endpoint: .allCategories
        )
      )
      XCTFail("Should throw NetworkError")
    } catch NetworkError.badURL(let request) {
      XCTAssertEqual(request.httpMethod, .get)
      XCTAssertEqual(request.endpoint, .allCategories)
      XCTAssertNil(request.headers)
      XCTAssertNil(request.data)
      expectation.fulfill()
    } catch {
      XCTFail("Expected `NetworkError.badURL` error.")
    }
    await fulfillment(of: [expectation], timeout: .zero)
  }

  func testNetworkRequestThrows_whenReceivedServerError() async throws {
    let sut = try NetworkManager(
      scheme: "https",
      baseURLString: "www.test.com",
      session: MockNetworkSession(
        baseURL: XCTUnwrap(baseURL),
        data: Data(),
        response: HTTPURLResponse(
          url: XCTUnwrap(baseURL),
          statusCode: 400,
          httpVersion: "testVersion",
          headerFields: nil
        )
      )
    )
    let expectation = expectation(description: "Wait for NetworkError error.")
    do {
      let _: NetworkResponse = try await sut.execute(
        request: NetworkRequest(
          httpMethod: .get,
          endpoint: .allCategories,
          headers: ["anyHeaderKey": "anyValue"]
        )
      )
      XCTFail("Should throw NetworkError")
    } catch NetworkError.serverError {
      expectation.fulfill()
    } catch {
      XCTFail("Expected `NetworkError.serverError` error.\n Received \(error)")
    }
    await fulfillment(of: [expectation], timeout: .zero)
  }
  /*
  func testNetworkRequestSuccess_whenCache() async throws {
    var cancellables = Set<AnyCancellable>()
    let obj = CategoriesData.Category(idCategory: "idCategory-1", strCategory: "strCategory-2", strCategoryThumb: "strCategoryThumb")
    let data: Data = try JSONEncoder().encode(obj)
    let sut = try NetworkManager(
      scheme: "https",
      baseURLString: baseURLString,
      session: MockNetworkSession(
        baseURL: XCTUnwrap(baseURL),
        data: data,
        response: HTTPURLResponse(
          url: XCTUnwrap(baseURL),
          statusCode: 200,
          httpVersion: "testVersion",
          headerFields: nil
        )
      )
    )
    var count = 0
    let request = NetworkRequest(
      httpMethod: .get,
      endpoint: .allCategories
    )
    request.subject.sink(
      receiveCompletion: { status in
        switch status {
          case .finished:
            print("finished receiving")
            XCTAssertEqual(count, 3)
          case .failure(let error):
            XCTFail("Expected to succeed but failed with \(error)")
        }
        
      }, receiveValue: { optionalResponse in
        count += 1
        print("StatusCode: \(String(describing: optionalResponse?.statusCode))")
        guard let data = optionalResponse?.data else {
          print("Data is `nil`")
          return
        }
        print("Object: \(String(describing: String(bytes: data, encoding: .utf8)))")
      })
    .store(in: &cancellables)
    await sut.executeRequest(
      request: request
    )
  }*/
}
