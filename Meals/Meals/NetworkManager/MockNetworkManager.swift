//
//  MockNetworkManager.swift
//  Meals
//
//  Created by Dipen Panchasara on 04/02/2024.
//

#if DEBUG
import Foundation

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
#endif
