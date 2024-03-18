//
//  NetworkManager.swift
//  Meals
//
//  Created by Dipen Panchasara on 31/01/2024.
//

import Foundation
import Combine

protocol NetworkProvider {
//  func execute<T>(networkRequest: NetworkRequest) -> AnyPublisher<T, Error> where T: Decodable
  func execute(networkRequest: NetworkRequest) -> AnyPublisher<NetworkResponse, Error>
}

final class NetworkManager: NetworkProvider {
  private let scheme: String
  private let baseURLString: String
  private let session: NetworkSessionProvider
  private let decoder: ResponseDecoderProvider
  private var cache: URLCache?

  init(
    scheme: String,
    baseURLString: String,
    session: NetworkSessionProvider,
    decoder: ResponseDecoderProvider
  ) {
    self.scheme = scheme
    self.baseURLString = baseURLString
    self.session = session
    self.decoder = decoder
  }
/*
  func execute<T>(networkRequest: NetworkRequest) -> AnyPublisher<T, Error> where T: Decodable  {
    var urlRequest: URLRequest
    do {
      urlRequest = try prepareURLRequest(networkRequest: networkRequest)
    } catch {
      return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
    
    return session.dataTaskPublisher(for: urlRequest)
      .tryMap {
        try self.handleResponse(result: $0)
      }
      .tryMap {
        guard let data = $0.data else { return nil }
        try self.decoder.decode(T.self, from: $0)
      }
      .eraseToAnyPublisher()
  }*/
  
  func execute(networkRequest: NetworkRequest) -> AnyPublisher<NetworkResponse, Error> {
    var urlRequest: URLRequest
    do {
      urlRequest = try prepareURLRequest(networkRequest: networkRequest)
    } catch {
      return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
    }
    
    return session.dataTaskPublisher(for: urlRequest)
      .tryMap {
        try self.handleResponse(result: $0)
      }
      .eraseToAnyPublisher()
  }
}

private extension NetworkManager {  
  func handleResponse(result: (data: Data, response: URLResponse)) throws -> NetworkResponse {
    print("Response data: \(result.data.count)")
    guard let httpURLResponse = result.response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
    switch httpURLResponse.statusCode {
      case 200...299:
        return NetworkResponse(data: result.data, urlResponse: httpURLResponse)
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
