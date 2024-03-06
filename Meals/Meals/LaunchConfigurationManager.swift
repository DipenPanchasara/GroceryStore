//
//  LaunchConfigurationManager.swift
//  Meals
//
//  Created by Dipen Panchasara on 04/02/2024.
//

import Foundation

class LaunchConfigurationManager {
  private let processInfo = ProcessInfo.processInfo

  /// Returns `scheme` string for the API endpoint.
  var scheme: String {
    guard
      let scheme = processInfo.environment["scheme"]
    else {
      return "https"
    }
    return scheme
  }

  /// Returns `baseURL` string for the API endpoint.
  var baseURLString: String {
    guard
      let urlString = processInfo.environment["baseURL"]
    else {
      return "www.themealdb.com"
    }
    return urlString
  }
}
