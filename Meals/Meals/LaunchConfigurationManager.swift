//
//  LaunchConfigurationManager.swift
//  Meals
//
//  Created by Dipen Panchasara on 04/02/2024.
//

import Foundation

class LaunchConfigurationManager {
  private let processInfo = ProcessInfo.processInfo

  /// Returns `baseURL` for the API endpoint.
  var baseURL: URL {
    guard
      let urlString = processInfo.environment["baseURL"],
      let url = URL(string: urlString)
    else { preconditionFailure("\"baseURL\" not defined") }
    return url
  }
}
