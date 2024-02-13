//
//  MockNetworkSession.swift
//  Meals
//
//  Created by Dipen Panchasara on 06/02/2024.
//

import Foundation
@testable import Meals

struct MockNetworkSession: NetworkSessionProvider {
  let baseURL: URL?
  let data: Data?
  let response: HTTPURLResponse?
  let error: Error
  
  struct NoStubError: Error {}
  
  init(
    baseURL: URL?,
    data: Data?,
    response: HTTPURLResponse?
  ) {
    self.baseURL = baseURL
    self.data = data
    self.response = response
    self.error = NoStubError()
  }
  
  init(error: Error) {
    self.error = error
    self.data = nil
    self.baseURL = nil
    self.response = nil
  }
  
  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    guard let data, let response else { throw error }
    return (data, response)
  }
}
