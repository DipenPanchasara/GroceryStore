//
//  NetworkError.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Foundation

enum NetworkError: Error, Equatable {
  static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    lhs.localizedDescription == rhs.localizedDescription
  }

  case badURL(request: NetworkRequest)
  case invalidResponse
  case serverError
  case failed(Error)
  case decodingFailed(String)
}
