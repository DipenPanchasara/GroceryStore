//
//  MealsApp.swift
//  Meals
//
//  Created by Dipen Panchasara on 29/01/2024.
//

import SwiftUI

@main
struct MealsApp: App {
  private let configurationManager = LaunchConfigurationManager()

  var body: some Scene {
    WindowGroup {
      RootView(
        viewModel: RootViewModel(
          scheme: configurationManager.scheme,
          baseURLString: configurationManager.baseURLString
        )
      )
    }
  }
}
