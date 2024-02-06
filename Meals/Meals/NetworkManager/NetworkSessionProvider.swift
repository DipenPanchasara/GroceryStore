//
//  NetworkSessionProvider.swift
//  Meals
//
//  Created by Dipen Panchasara on 06/02/2024.
//

import Foundation

protocol NetworkSessionProvider: Sendable {
  func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
extension URLSession: NetworkSessionProvider {}
