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

  func testNetworkRequestSuccessWithoutCache() async throws {
    let mockResponseString = "mockResponseData"
    let mockResponseData = try XCTUnwrap(mockResponseString.data(using: .utf8))
    let mockHTTPResponse = try XCTUnwrap(HTTPURLResponse(
      url: XCTUnwrap(baseURL),
      statusCode: 200,
      httpVersion: "testVersion",
      headerFields: ["anyHeaderKey": "anyHeaderValue"]
    ))
    let mockNetworkResponse = NetworkResponse(data: mockResponseData, response: mockHTTPResponse)
    let subject: PassthroughSubject<(data: Data, response: URLResponse), Error> = PassthroughSubject()
    
    let mockSession = MockNetworkSessionProvider()
    stub(mockSession) { proxy in
      when(proxy)
        .dataTaskPublisher(for: any())
        .thenReturn(
          subject.eraseToAnyPublisher()
        )
    }
    
    let sut = NetworkManager(
      scheme: "https",
      baseURLString: baseURLString,
      session: mockSession,
      cache: MockNetworkCacheManager(error: MockError.noCache),
      decoder: ResponseDecoder()
    )
    let publisher = sut.executeWithCache(
      networkRequest: NetworkRequest(
        httpMethod: .get,
        endpoint: .allCategories
      )
    )
    
    let spy = NetworkPublisherSpy(publisher)
    XCTAssertTrue(spy.values.isEmpty)
    XCTAssertNil(spy.error)
    
    subject.send((data: mockResponseData, response: mockHTTPResponse))
    XCTAssertEqual(spy.values, [mockNetworkResponse])
    XCTAssertNil(spy.error)
  }
  
  func testNetworkRequestSuccessWithCache() async throws {
    let mockResponseString = "mockResponseData"
    let mockResponseData = try XCTUnwrap(mockResponseString.data(using: .utf8))
    let mockCacheResponseString = "mockCacheResponseData"
    let mockCacheResponseData = try XCTUnwrap(mockCacheResponseString.data(using: .utf8))
    let mockHTTPResponse = try XCTUnwrap(HTTPURLResponse(
      url: XCTUnwrap(baseURL),
      statusCode: 200,
      httpVersion: "testVersion",
      headerFields: ["anyHeaderKey": "anyHeaderValue"]
    ))
    let mockCacheNetworkResponse = NetworkResponse(data: mockCacheResponseData, response: mockHTTPResponse)
    let mockNetworkResponse = NetworkResponse(data: mockResponseData, response: mockHTTPResponse)
    let subject: PassthroughSubject<(data: Data, response: URLResponse), Error> = PassthroughSubject()
    
    let mockSession = MockNetworkSessionProvider()
    stub(mockSession) { proxy in
      when(proxy)
        .dataTaskPublisher(for: any())
        .thenReturn(
          subject.eraseToAnyPublisher()
        )
    }

    let sut = NetworkManager(
      scheme: "https",
      baseURLString: baseURLString,
      session: mockSession,
      cache: MockNetworkCacheManager(response: mockCacheNetworkResponse),
      decoder: ResponseDecoder()
    )
    let publisher = sut.executeWithCache(
      networkRequest: NetworkRequest(
        httpMethod: .get,
        endpoint: .allCategories
      )
    )

    let spy = NetworkPublisherSpy(publisher)
    XCTAssertEqual(spy.values, [mockCacheNetworkResponse])
    XCTAssertNil(spy.error)
    
    subject.send((data: mockResponseData, response: mockHTTPResponse))
    XCTAssertEqual(spy.values, [mockCacheNetworkResponse, mockNetworkResponse])
    XCTAssertNil(spy.error)
  }

  func testNetworkRequest_whenPreparingURLRequestSucceed() async throws {
    let sut = NetworkManager(
      scheme: "https",
      baseURLString: "www.test.com",
      session: URLSession.shared,
      cache: MockNetworkCacheManager(error: MockError.noCache),
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
      cache: MockNetworkCacheManager(error: MockError.noCache),
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
    let subject: PassthroughSubject<(data: Data, response: URLResponse), Error> = PassthroughSubject()

    let mockSession = MockNetworkSessionProvider()
    stub(mockSession) { proxy in
      when(proxy)
        .dataTaskPublisher(for: any())
        .thenReturn(
          subject.eraseToAnyPublisher()
        )
    }

    let sut = NetworkManager(
      scheme: "https",
      baseURLString: baseURLString,
      session: mockSession,
      cache: MockNetworkCacheManager(error: MockError.noCache),
      decoder: ResponseDecoder()
    )
    let publisher = sut.executeWithCache(
      networkRequest: NetworkRequest(
        httpMethod: .get,
        endpoint: .allCategories
      )
    )

    let spy = NetworkPublisherSpy(publisher)
    XCTAssertTrue(spy.values.isEmpty)
    XCTAssertNil(spy.error)

    subject.send((data: mockResponseData, response: mockHTTPResponse))
    XCTAssertTrue(spy.values.isEmpty)
    XCTAssertNotNil(spy.error)
  }
}

enum MockError: Error {
  case networkFailure
  case noCache
}
