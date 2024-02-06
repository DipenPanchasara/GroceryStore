//
//  NetworkManagerUnitTests.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 03/02/2024.
//

@testable import Meals
import XCTest

final class NetworkManagerUnitTests: XCTestCase {
  enum MockError: Error {
    case decodingFailed
    case serverError
    case networkError
  }

  func testNetworkRequestSuccess() async throws {
    let obj = CategoriesData.Category(idCategory: "idCategory", strCategory: "strCategory", strCategoryThumb: "strCategoryThumb")
    let data: Data = try JSONEncoder().encode(obj)
    let baseURL = try XCTUnwrap(URL(string: "https://www.test.com"))
    let networkManager = NetworkManager(
      baseURL: baseURL,
      session: MockNetworkSession(
        baseURL: baseURL,
        data: data,
        response: HTTPURLResponse(url: baseURL, statusCode: 200, httpVersion: "testVersion", headerFields: nil)
      ),
      decoder: MockResponseDecoder(object: CategoriesData.Category(idCategory: "idCategory", strCategory: "strCategory", strCategoryThumb: "strCategoryThumb"))
    ) 
    
    let result: CategoriesData.Category = try await networkManager.execute(request: URLRequest(url: baseURL))
    XCTAssertEqual(result.idCategory, "idCategory")
  }
  
  func testNetworkRequestThrows_whenNetworkError() async throws {
    let baseURL = try XCTUnwrap(URL(string: "https://www.test.com"))
    let networkManager = NetworkManager(
      baseURL: baseURL,
      session: MockNetworkSession(error: MockError.networkError),
      decoder: MockResponseDecoder(
        object: CategoriesData.Category(
          idCategory: "idCategory",
          strCategory: "strCategory",
          strCategoryThumb: "strCategoryThumb"
        )
      )
    )
    
    do {
      let _: CategoriesData.Category = try await networkManager.execute(request: URLRequest(url: baseURL))
      XCTFail("Should throw")
    } catch {
      guard
        let err = error as? MockError
      else {
        XCTFail("Expected `NetworkError` type.")
        return
      }
      switch err {
        case .networkError:
          break
        default:
          XCTFail("Expected `networkError` error.")
      }
    }

  }

  func testNetworkRequestThrows_whenFailedStatusCode() async throws {
    let baseURL = try XCTUnwrap(URL(string: "https://www.test.com"))
    let networkManager = NetworkManager(
      baseURL: baseURL,
      session: MockNetworkSession(
        baseURL: baseURL,
        data: Data(),
        response: HTTPURLResponse(url: baseURL, statusCode: 300, httpVersion: "testVersion", headerFields: nil)
      ),
      decoder: MockResponseDecoder(
        object: CategoriesData.Category(
          idCategory: "idCategory",
          strCategory: "strCategory",
          strCategoryThumb: "strCategoryThumb"
        )
      )
    )

    do {
      let _: CategoriesData.Category = try await networkManager.execute(request: URLRequest(url: baseURL))
      XCTFail("Should throw")
    } catch {
      guard
        let err = error as? NetworkError
      else {
        XCTFail("Expected `NetworkError` type.")
        return
      }
      switch err {
        case .invalidData:
          break
        default:
          XCTFail("Expected `invalidData` error.")
      }
    }
  }
  
  func testNetworkRequestThrows_whenDecodingFails() async throws {
    let obj = CategoriesData.Category(idCategory: "idCategory", strCategory: "strCategory", strCategoryThumb: "strCategoryThumb")
    let data: Data = try JSONEncoder().encode(obj)
    let baseURL = try XCTUnwrap(URL(string: "https://www.test.com"))
    let networkManager = NetworkManager(
      baseURL: baseURL,
      session: MockNetworkSession(
        baseURL: baseURL,
        data: data,
        response: HTTPURLResponse(url: baseURL, statusCode: 200, httpVersion: "testVersion", headerFields: nil)
      ),
      decoder: MockResponseDecoder(error: MockError.decodingFailed)
    )
    
    do {
      let _: CategoriesData.Category = try await networkManager.execute(request: URLRequest(url: baseURL))
      XCTFail("Should throw")
    } catch {
      guard
        let err = error as? NetworkError
      else {
        XCTFail("Expected `NetworkError` type.")
        return
      }
      switch err {
        case .decodingFailed(let error):
          XCTAssertEqual(error as? NetworkManagerUnitTests.MockError, MockError.decodingFailed)
          break
        default:
          XCTFail("Expected `decodingFailed` error.")
      }
    }

  }
}
