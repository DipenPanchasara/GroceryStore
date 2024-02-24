//
//  NetworkRequest.swift
//  Meals
//
//  Created by Dipen Panchasara on 12/02/2024.
//

import Foundation

struct NetworkRequest: Equatable {
  enum HTTPType: String {
    case get
    case post
    case put
    case delete

    var value: String {
      self.rawValue.capitalized
    }
  }

  let httpMethod: HTTPType
  let endpoint: Endpoints
  let headers: [String: String]?
  let data: Data?

  init(
    httpMethod: HTTPType,
    endpoint: Endpoints,
    headers: [String: String]? = nil,
    data: Data? = nil
  ) {
    self.httpMethod = httpMethod
    self.endpoint = endpoint
    self.headers = headers
    self.data = data
  }
}
