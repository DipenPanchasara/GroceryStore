//
//  CategoryRouterViewModifier.swift
//  Meals
//
//  Created by Dipen Panchasara on 16/02/2024.
//

import SwiftUI

extension View {
  func withCategoryRoutes(categoryViewModelFactory: CategoryViewModelFactoryProtocol) -> some View {
    self.navigationDestination(for: CategoryRoutes.self) { destination in
      switch destination {
      case .foodItems(let categoryName):
        FoodItemsView(
          viewModel: categoryViewModelFactory.foodItemsViewModel(
            categoryName: categoryName
          )
        )
      }
    }
  }
}

struct TestView: View {
  let categoryModel: CategoryModel
  var body: some View {
    Text("This is \(categoryModel.name)")
  }
}
