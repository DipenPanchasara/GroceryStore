//
//  NetworkManager.swift
//  Meals
//
//  Created by Dipen Panchasara on 31/01/2024.
//

import Foundation
/*
 
 API for Meals
 
 https://www.themealdb.com/api.php
 
 */

protocol NetworkProvider {
  func execute<T:Decodable>(request: URLRequest) async throws -> T
}

struct NetworkManager: NetworkProvider {  
  private let sessionConfiguration = URLSessionConfiguration.default
  private let baseURL: URL
  private let session: NetworkSessionProvider
  private let decoder: ResponseDecoderProvider
  
  init(
    baseURL: URL,
    session: NetworkSessionProvider,
    decoder: ResponseDecoderProvider = ResponseDecoder()
  ) {
    self.baseURL = baseURL
    self.session = session
    self.decoder = decoder
  }
  
  func execute<T: Decodable>(request: URLRequest) async throws -> T {
    do {
      let (data, response) = try await session.data(for: request)
      guard let responseCode = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
      
      switch responseCode.statusCode {
        case 200...299: 
          do {
            let object = try decoder.decode(T.self, from: data)
            return object
          } catch {
            throw NetworkError.decodingFailed(error)
          }
        default:
          throw NetworkError.invalidData
      }
    } catch {
      throw error
    }
  }
}
