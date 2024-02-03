//
//  MealsApp.swift
//  Meals
//
//  Created by Dipen Panchasara on 29/01/2024.
//

import SwiftUI

@main
struct MealsApp: App {
    var body: some Scene {
        WindowGroup {
          CategoriesView(
            viewModel: CategoriesViewModel(
              useCase: CategoriesUseCase(
                networkManager: NetworkManager(baseURL: URL(string: "https://www.themealdb.com")!)
              )
            )
          )
        }
    }
}
