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

final class ResponseDecoder: JSONDecoder, ResponseDecoderProvider {
  override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
    do {
      return try super.decode(type, from: data)
    } 
    catch DecodingError.typeMismatch(let type, let context) {
      let errorMessage = "Decoding Error: \n" +
            "TypeMismatch: \(type),\n" +
            "for CodingPath \(context.codingPath),\n" +
            "Description: \(context.debugDescription)"
      throw DecoderError.decodingFailed(errorMessage)
    }
    catch DecodingError.valueNotFound(let value, let context) {
      let errorMessage = "Decoding Error: \n" +
            "ValueNotFound: \(value),\n" +
            "for CodingPath \(context.codingPath),\n" +
            "Description: \(context.debugDescription)"
      throw DecoderError.decodingFailed(errorMessage)
    }
    catch DecodingError.keyNotFound(let key, let context) {
      let errorMessage = "Decoding Error: \n" +
            "KeyNotFound: \(key),\n" +
            "for CodingPath \(context.codingPath),\n" +
            "Description: \(context.debugDescription)"
      throw DecoderError.decodingFailed(errorMessage)
    }
    catch DecodingError.dataCorrupted(let context) {
      let errorMessage = "Decoding Error: DataCurrupted\n" +
            "for CodingPath \(context.codingPath),\n" +
            "Description: \(context.debugDescription)"
      throw DecoderError.decodingFailed(errorMessage)
    }
    catch {
      print("Decoding Error: Unknown error")
      throw DecoderError.decodingFailed(error.localizedDescription)
    }
  }
}

extension ResponseDecoder {
  enum DecoderError: Error {
    case decodingFailed(String)
  }
}

/*
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
*/
