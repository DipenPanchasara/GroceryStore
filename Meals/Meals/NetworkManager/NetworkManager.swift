//
//  NetworkManager.swift
//  Meals
//
//  Created by Dipen Panchasara on 31/01/2024.
//

import Foundation
import Combine

protocol NetworkProvider {
  func execute<T>(networkRequest: NetworkRequest) -> AnyPublisher<T, Error> where T: Decodable
  func executeWithCache(networkRequest: NetworkRequest) -> AnyPublisher<NetworkResponse, Error>
}

final class NetworkManager: NetworkProvider {
  private let scheme: String
  private let baseURLString: String
  private let session: NetworkSessionProvider
  private let cache: NetworkCacheProvider
  private let decoder: ResponseDecoderProvider

  init(
    scheme: String,
    baseURLString: String,
    session: NetworkSessionProvider,
    cache: NetworkCacheProvider,
    decoder: ResponseDecoderProvider
  ) {
    self.scheme = scheme
    self.baseURLString = baseURLString
    self.session = session
    self.cache = cache
    self.decoder = decoder
  }

  func execute<T>(networkRequest: NetworkRequest) -> AnyPublisher<T, Error> where T: Decodable  {
    var urlRequest: URLRequest
    do {
      urlRequest = try prepareURLRequest(networkRequest: networkRequest)
    } catch {
      return Fail(error: URLError(.badURL))
        .eraseToAnyPublisher()
    }
    
    return session.dataTaskPublisher(for: urlRequest)
      .tryMap {
        try self.handleResponse(result: $0)
      }
      .tryMap { response in
        guard let data = response.data else {
          throw URLError(.zeroByteResource)
        }
        return data
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
  
  func executeWithCache(networkRequest: NetworkRequest) -> AnyPublisher<NetworkResponse, Error> {
    var urlRequest: URLRequest
    do {
      urlRequest = try prepareURLRequest(networkRequest: networkRequest)
    } catch {
      return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
    
    let cachedPublisher = cache.cached(urlRequest: urlRequest)
      .filter { $0.data != nil }

    let networkPublisher = session.dataTaskPublisher(for: urlRequest)
      .tryMap {
        try self.handleResponse(result: $0)
      }
      .eraseToAnyPublisher()
    
    return Publishers.Merge(cachedPublisher, networkPublisher)
      .eraseToAnyPublisher()
  }
  
//  private func cached(urlRequest: URLRequest) -> AnyPublisher<NetworkResponse, Error> {
//    if let cachedResponse = session.session.configuration.urlCache?.cachedResponse(for: urlRequest) {
//      return Just(cachedResponse)
//        .tryMap {
//          try self.handleResponse(result: ($0.data, $0.response))
//        }
//        .eraseToAnyPublisher()
//    }
//    let httpResponse = HTTPURLResponse(url: urlRequest.url!, statusCode: 400, httpVersion: nil, headerFields: nil)!
//    return Just(
//      NetworkResponse(
//        data: nil,
//        response: httpResponse
//      )
//    )
//    .setFailureType(to: Error.self)
//    .eraseToAnyPublisher()
//  }
}

private extension NetworkManager {  
  func handleResponse(result: (data: Data, response: URLResponse)) throws -> NetworkResponse {
    print("Response data: \(result.data.count)")
    guard let httpURLResponse = result.response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
    switch httpURLResponse.statusCode {
      case 200...299:
        return NetworkResponse(data: result.data, response: httpURLResponse)
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

protocol NetworkCacheProvider {
  func cached(urlRequest: URLRequest) -> AnyPublisher<NetworkResponse, Error>
}

struct NetworkCacheManager: NetworkCacheProvider {
  private let session: URLSession
  
  init(session: URLSession) {
    self.session = session
  }

  func cached(urlRequest: URLRequest) -> AnyPublisher<NetworkResponse, Error> {
    if let cachedResponse = session.configuration.urlCache?.cachedResponse(for: urlRequest) {
      return Just(NetworkResponse(data: cachedResponse.data, response: cachedResponse.response as! HTTPURLResponse))
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
    let httpResponse = HTTPURLResponse(url: urlRequest.url!, statusCode: 400, httpVersion: nil, headerFields: nil)!
    return Just(NetworkResponse(data: nil, response: HTTPURLResponse()))
    .setFailureType(to: Error.self)
    .eraseToAnyPublisher()
  }
}
