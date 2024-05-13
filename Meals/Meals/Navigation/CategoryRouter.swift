//
//  CategoryRouter.swift
//  Meals
//
//  Created by Dipen Panchasara on 16/02/2024.
//

import SwiftUI

enum CategoryRoutes: Hashable, Equatable {
  case foodItems(categoryName: String)
  case foodDetail(item: FoodItemModel)
}

protocol CategoryRouterProtocol: ModuleRouter {
  func push(destination: CategoryRoutes)
  func pop()
  func popToRootView()
}

final class CategoryRouter: CategoryRouterProtocol, ObservableObject {
  var router: RouterProtocol

  init(router: RouterProtocol) {
    self.router = router
  }

  @MainActor
  func push(destination: CategoryRoutes) {
    router.push(destination: destination)
  }

  @MainActor
  func pop() {
    router.pop()
  }

  @MainActor
  func popToRootView() {
    router.popToRootView()
  }
}
