//
//  NetworkManagerUnitTests.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 03/02/2024.
//

@testable import Meals
import Combine
import Cuckoo
import XCTest

final class NetworkManagerUnitTests: XCTestCase {
  private var cancellables = Set<AnyCancellable>()
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
    let mockResponseString = "mockResponseData"
    let mockResponseData = try XCTUnwrap(mockResponseString.data(using: .utf8))
    let mockHTTPResponse = try XCTUnwrap(HTTPURLResponse(
      url: XCTUnwrap(baseURL),
      statusCode: 200,
      httpVersion: "testVersion",
      headerFields: nil
    ))
    let mockSession = MockNetworkSessionProvider()
    stub(mockSession) { proxy in
      when(proxy)
        .dataTaskPublisher(for: any())
        .thenReturn(
          Just(
            (mockResponseData, mockHTTPResponse)
          )
          .setFailureType(to: Error.self)
          .eraseToAnyPublisher()
        )
    }
    let expectation = expectation(description: "wait for response")
    let sut = NetworkManager(
      scheme: "https",
      baseURLString: baseURLString,
      session: mockSession,
      decoder: ResponseDecoder()
    )
    sut.execute(
      networkRequest: NetworkRequest(
        httpMethod: .get,
        endpoint: .allCategories
      )
    )
    .sink { completion in
      switch completion {
        case .finished:
          expectation.fulfill()
        case .failure(let error):
          XCTFail("Expected success response, receive error: \(error)")
      }
    } receiveValue: { response in
      guard let data = response.data else {
        XCTFail("Invalid response.")
        return
      }
      let string = String(bytes: data, encoding: .utf8)
      XCTAssertEqual(string, mockResponseString)
      XCTAssertEqual(response.urlResponse.statusCode, 200)
    }
    .store(in: &cancellables)
    await fulfillment(of: [expectation], timeout: .zero)
  }

  func testNetworkRequest_whenPreparingURLRequestSucceed() async throws {
    let sut = NetworkManager(
      scheme: "https",
      baseURLString: "www.test.com",
      session: URLSession.shared,
      decoder: ResponseDecoder()
    )
    let request = NetworkRequest(
      httpMethod: .get,
      endpoint: .foodItemsByCategory(categoryName: "anyCategory"),
      headers: ["anyKey": "anyvalue"]
    )
    let result = try sut.prepareURLRequest(networkRequest: request)
    XCTAssertEqual(result.url?.scheme, "https")
    XCTAssertEqual(result.url?.host(), "www.test.com")
    XCTAssertEqual(result.url?.path(), "/api/json/v1/1/filter.php")
    XCTAssertEqual(result.allHTTPHeaderFields, ["anyKey": "anyvalue"])
    XCTAssertEqual(result.httpMethod, "GET")
    XCTAssertEqual(result.url?.query(), "c=anyCategory")
  }

  func testNetworkRequest_whenThrowsBadURL() async throws {
    let sut = NetworkManager(
      scheme: "https",
      baseURLString: "https://www.test.com",
      session: URLSession.shared,
      decoder: ResponseDecoder()
    )
    let request = NetworkRequest(
      httpMethod: .get,
      endpoint: .allCategories
    )
    XCTAssertThrowsError(try sut.prepareURLRequest(
      networkRequest: request
    )) { error in
      guard let networkError = error as? NetworkError else {
        XCTFail("Should throw NetworkError.badURL")
        return
      }
      XCTAssertEqual(networkError, NetworkError.badURL(request: request))
    }
  }

  func testNetworkRequestThrows_whenReceivedServerError() async throws {
    let mockResponseString = "mockResponseData"
    let mockResponseData = try XCTUnwrap(mockResponseString.data(using: .utf8))
    let mockHTTPResponse = try XCTUnwrap(HTTPURLResponse(
      url: XCTUnwrap(baseURL),
      statusCode: 300,
      httpVersion: "testVersion",
      headerFields: ["anyHeaderKey": "anyHeaderValue"]
    ))
    let mockSession = MockNetworkSessionProvider()
    stub(mockSession) { proxy in
      when(proxy)
        .dataTaskPublisher(for: any())
        .thenReturn(
          Just(
            (mockResponseData, mockHTTPResponse)
          )
          .setFailureType(to: Error.self)
          .eraseToAnyPublisher()
        )
    }
    let expectation = expectation(description: "wait for response")
    let sut = NetworkManager(
      scheme: "https",
      baseURLString: baseURLString,
      session: mockSession,
      decoder: ResponseDecoder()
    )
    sut.execute(
      networkRequest: NetworkRequest(
        httpMethod: .get,
        endpoint: .allCategories
      )
    )
    .sink { completion in
      switch completion {
        case .finished:
          XCTFail("Should throw badServerResponse.")
        case .failure(let error):
          guard let urlError = error as? URLError else {
            XCTFail("Should throw badServerResponse")
            return
          }
          XCTAssertEqual(urlError, URLError(.badServerResponse))
          expectation.fulfill()
      }
    } receiveValue: { _ in
      XCTFail("Should throw badServerResponse.")
    }
    .store(in: &cancellables)
    await fulfillment(of: [expectation], timeout: .zero)
  }
}

