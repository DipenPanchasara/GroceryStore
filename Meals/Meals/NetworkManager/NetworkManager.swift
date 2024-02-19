//
//  NetworkManager.swift
//  Meals
//
//  Created by Dipen Panchasara on 31/01/2024.
//

import Foundation
import Combine
/*
 
 API for Meals
 
 https://www.themealdb.com/api.php
 
 */

protocol NetworkProvider {
  func execute(request: NetworkRequest) async throws -> NetworkResponse
}

final class NetworkManager: NetworkProvider {
  private let sessionConfiguration = URLSessionConfiguration.default
  private let scheme: String
  private let baseURLString: String
  private let session: NetworkSessionProvider
  
  init(
    scheme: String,
    baseURLString: String,
    session: NetworkSessionProvider
  ) {
    self.scheme = scheme
    self.baseURLString = baseURLString
    self.session = session
  }

  func execute(request: NetworkRequest) async throws -> NetworkResponse {
    do {
      let request = try prepareURLRequest(networkRequest: request)
      let (data, response) = try await session.data(for: request)
      guard let httpURLResponse = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
      
      switch httpURLResponse.statusCode {
        case 200...299:
          return NetworkResponse(data: data, urlResponse: httpURLResponse)
        default:
          throw NetworkError.serverError
      }
    } catch {
      throw error
    }
  }
}

extension NetworkManager {
  func prepareURLRequest(networkRequest: NetworkRequest) throws -> URLRequest {
    var components = URLComponents()
    components.scheme = self.scheme
    components.host = self.baseURLString
    components.path = "/api/json/v1/1/\(networkRequest.endpoint.rawValue)"

    guard 
      let url = components.url
    else {
      throw NetworkError.badURL(request: networkRequest)
    }
    var request = URLRequest(url: url)
    request.httpMethod = networkRequest.httpMethod.value
    request.httpBody = networkRequest.data
    if let headers = networkRequest.headers {
      request.allHTTPHeaderFields = headers
    }
    return request
  }
}
