//
//  NetworkSessionProvider.swift
//  Meals
//
//  Created by Dipen Panchasara on 06/02/2024.
//

import Foundation
import Combine

protocol NetworkSessionProvider: Sendable {
//  func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
  func dataTaskPublisher(for urlRequest: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), any Error>
//  var configuration: URLSessionConfiguration { get }
  var session: URLSession { get }
}

extension URLSession: NetworkSessionProvider {
//  var configuration: URLSessionConfiguration {
//    session.configuration
//  }
  
  var session: URLSession {
    .shared
  }
  
  func dataTaskPublisher(for urlRequest: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), any Error> {
    URLSession.DataTaskPublisher(request: urlRequest, session: session)
      .tryMap {
        ($0.data, $0.response)
      }
      .eraseToAnyPublisher()
  }
}
