//
//  NetworkManager.swift
//  Meals
//
//  Created by Dipen Panchasara on 31/01/2024.
//

import Foundation
import Combine

protocol NetworkProvider {
  func execute(request: NetworkRequest) async throws -> NetworkResponse
  func execute<T>(networkRequest: NetworkRequest) -> AnyPublisher<T, Error> where T: Decodable
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

  func execute<T>(networkRequest: NetworkRequest) -> AnyPublisher<T, Error> where T: Decodable  {
    var urlRequest: URLRequest
    do {
      urlRequest = try prepareURLRequest(networkRequest: networkRequest)
    } catch {
      return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
    
    return dataTaskPublisher(urlRequest: urlRequest)
      .tryMap { result in
        try self.handleResponse(result: result)
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}

private extension NetworkManager {
  func dataTaskPublisher(urlRequest: URLRequest) -> URLSession.DataTaskPublisher {
    let publisher = session.dataTaskPublisher(for: urlRequest)
    return publisher
  }
  
  func handleResponse(result: (data: Data, response: URLResponse)) throws -> Data {
    print("Response data: \(result.data.count)")
    guard let httpURLResponse = result.response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
    switch httpURLResponse.statusCode {
      case 200...299:
        return result.data
      default:
        throw URLError(.badServerResponse)
    }
  }
}

extension NetworkManager {
  func prepareURLRequest(networkRequest: NetworkRequest) throws -> URLRequest {
    let endpoint = networkRequest.endpoint
    var components = URLComponents()
    components.scheme = scheme
    components.host = baseURLString
    components.path = "/api/json/v1/1/\(endpoint.path)"
    if let queryItems = endpoint.queryItems {
      components.queryItems = queryItems.map { queryItem in
        URLQueryItem(name: queryItem.key, value: queryItem.value)
      }
    }
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
