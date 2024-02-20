//
//  CategoryRouter.swift
//  Meals
//
//  Created by Dipen Panchasara on 16/02/2024.
//

import SwiftUI

enum CategoryRoutes: Hashable {
  case foodItems(categoryName: String)
}

protocol CategoryRouterProtocol: RouterProtocol {
  func push(destination: CategoryRoutes)
  func pop()
  func popToRootView()
}

final class CategoryRouter: CategoryRouterProtocol, ObservableObject {
  var router: Router

  init(router: Router) {
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
