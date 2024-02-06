//
//  ResponseDecoder.swift
//  Meals
//
//  Created by Dipen Panchasara on 04/02/2024.
//

import Foundation

protocol ResponseDecoderProvider {
  func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

class ResponseDecoder: JSONDecoder, ResponseDecoderProvider {
  override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
    try super.decode(type, from: data)
  }
}

class MockResponseDecoder: ResponseDecoderProvider {
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
  
  func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
    guard let model = object as? T else { throw error }
    return model
  }
}

