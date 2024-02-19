//
//  CategoryRouterViewModifier.swift
//  Meals
//
//  Created by Dipen Panchasara on 16/02/2024.
//

import SwiftUI

extension View {
  func withCategoryRoutes(router: CategoryRouter) -> some View {
    self.navigationDestination(for: CategoryRouter.Route.self) { destination in
      switch destination {
        case .categoryItems(let model):
          TestView(categoryModel: model)
            .navigationTitle(model.name)
            .toolBarStyle()
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
