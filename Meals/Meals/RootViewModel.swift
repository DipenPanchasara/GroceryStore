//
//  RootViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 04/02/2024.
//

import SwiftUI

class RootViewModel: ObservableObject {
  private(set) var baseURL: URL

  @Published var path = NavigationPath()
  
  init(baseURL: URL) {
    self.baseURL = baseURL
  }
}
