//
//  MockNetworkManager.swift
//  Meals
//
//  Created by Dipen Panchasara on 04/02/2024.
//

import Foundation
@testable import Meals

struct MockNetworkManager: NetworkProvider {
  let response: NetworkResponse?
  let error: Error

  struct NoStubError: Error {}

  init(response: NetworkResponse) {
    self.response = response
    self.error = NoStubError()
  }

  init(error: Error) {
    self.error = error
    self.response = nil
  }

  func execute(request: NetworkRequest) async throws -> NetworkResponse {
    guard let response = response else { throw error }
    return response
  }
}
