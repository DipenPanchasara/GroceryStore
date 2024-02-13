//
//  RootViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 04/02/2024.
//

import SwiftUI

class RootViewModel: ObservableObject {
  private let sessionConfiguration = URLSessionConfiguration.default

  private(set) var scheme: String
  private(set) var baseURLString: String
  private(set) var session: URLSession

  @Published var path = NavigationPath()
  
  init(scheme: String, baseURLString: String) {
    self.scheme = scheme
    self.baseURLString = baseURLString
    self.sessionConfiguration.timeoutIntervalForRequest = 60
    self.sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    self.session = URLSession(configuration: sessionConfiguration)
  }
}
