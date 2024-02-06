//
//  RootViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 04/02/2024.
//

import SwiftUI

class RootViewModel: ObservableObject {
  private let sessionConfiguration = URLSessionConfiguration.default

  private(set) var baseURL: URL
  private(set) var session: URLSession

  @Published var path = NavigationPath()
  
  init(baseURL: URL) {
    self.baseURL = baseURL
    self.sessionConfiguration.timeoutIntervalForRequest = 60
    self.sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    self.session = URLSession(configuration: sessionConfiguration)
  }
}
