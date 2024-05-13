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
        case .foodDetail(let model):
          TestView(model: model)
          .backgroundColor()
      }
    }
  }
}

struct TestView: View {
  let model: FoodItemModel
  var body: some View {
    VStack {
      Text("This is \(model.id)")
      Text("This is \(model.name)")
      Text("This is \(model.thumbURL)")
      Spacer()
    }
    .frame(maxWidth: .infinity)
  }
}
