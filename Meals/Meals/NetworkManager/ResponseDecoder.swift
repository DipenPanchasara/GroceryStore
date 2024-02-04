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
