//
//  RootViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 04/02/2024.
//

import SwiftUI

class RootViewModel: ObservableObject {
  // TODO: Move base URL into xcconfig later.
  private(set) var baseURL = URL(string: "https://www.themealdb.com")!

  @Published var path = NavigationPath()
}
