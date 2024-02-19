//
//  CategoryRouter.swift
//  Meals
//
//  Created by Dipen Panchasara on 16/02/2024.
//

import SwiftUI

extension CategoryRouter {
  enum Route: Hashable {
    case categoryItems(model: CategoryModel)
  }
}

protocol CategoryFlowRouter: FlowRouter {
  func push(destination: CategoryRouter.Route)
  func pop()
  func popToRootView()
}

final class CategoryRouter: CategoryFlowRouter, ObservableObject {
  var router: Router

  init(router: Router) {
    self.router = router
  }
  
  @MainActor
  func push(destination: CategoryRouter.Route) {
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
