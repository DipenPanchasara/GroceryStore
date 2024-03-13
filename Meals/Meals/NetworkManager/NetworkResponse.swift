//
//  NetworkResponse.swift
//  Meals
//
//  Created by Dipen Panchasara on 12/02/2024.
//

import Foundation
import Combine

struct NetworkResponse: Equatable {
  let data: Data?
  let urlResponse: HTTPURLResponse
}

extension NetworkResponse {
  func decode<T: Decodable>(decoder: ResponseDecoder = ResponseDecoder()) throws -> T {
    guard let data = self.data else { throw URLError(.cannotDecodeContentData) }
    return try decoder.decode(T.self, from: data)
  }
}
