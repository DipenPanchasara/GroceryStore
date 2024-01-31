//
//  NetworkManager.swift
//  Meals
//
//  Created by Dipen Panchasara on 31/01/2024.
//

import Foundation

protocol NetworkProvider {
  func execute<T:Decodable>(request: URLRequest) async throws -> T
}

struct NetworkManager: NetworkProvider {
  enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case failed(Error)
    case decodingFailed(Error)
  }
  
  private let sessionConfiguration = URLSessionConfiguration.default
  private let session: URLSession
  
  init() {
    self.sessionConfiguration.timeoutIntervalForRequest = 60
    self.sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    self.session = URLSession(configuration: sessionConfiguration)
  }
  
  func execute<T: Decodable>(request: URLRequest) async throws -> T {
    do {
      let (data, response) = try await session.data(for: request)
      guard let responseCode = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
      
      switch responseCode.statusCode {
        case 200...299: 
          do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
          } catch {
            throw NetworkError.decodingFailed(error)
          }
        default:
          throw NetworkError.invalidData
      }
    } catch {
      throw NetworkError.failed(error)
    }
  }
}

protocol DecoderProvider {
  func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

class Decoder: JSONDecoder, DecoderProvider {
  override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
    try super.decode(type, from: data)
  }
}


struct MockNetworkManager: NetworkProvider {
  let object: Decodable?
  let error: Error
  
  struct NoStubError: Error {}
  
  init(object: Decodable) {
    self.object = object
    self.error = NoStubError()
  }
  
  init(error: Error) {
    self.error = error
    self.object = nil
  }
  
  func execute<T: Decodable>(request: URLRequest) async throws -> T {
    guard let model = object as? T else { throw error }
    return model
  }
}
