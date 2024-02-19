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
  @StateObject private var router = Router(path: NavigationPath())

  var body: some Scene {
    WindowGroup {
      RootView(
        viewModel: RootViewModel(
          scheme: configurationManager.scheme,
          baseURLString: configurationManager.baseURLString,
          router: router
        )
      )
    }
  }
}
