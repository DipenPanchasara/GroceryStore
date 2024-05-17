//
//  MockNetworkCacheManager.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 16/05/2024.
//

@testable import Meals
import Combine
import Foundation

struct MockNetworkCacheManager: NetworkCacheProvider {
  private let response: NetworkResponse?
  private let error: Error
  
  struct NoStubError: Error {}
  
  init(response: NetworkResponse?) {
    self.response = response
    self.error = NoStubError()
  }
  
  init(error: Error) {
    self.error = error
    self.response = nil
  }
  
  func cached(urlRequest: URLRequest) -> AnyPublisher<NetworkResponse, Error> {
    guard let response else {
      return Just(NetworkResponse(data: nil, response: HTTPURLResponse()))
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
    return Just(response)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }
}
