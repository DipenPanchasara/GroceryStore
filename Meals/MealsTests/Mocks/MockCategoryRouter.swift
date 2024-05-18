//
//  MockCategoryRouter.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 18/05/2024.
//

@testable import Meals
import Foundation

final class MockCategoryRouter: CategoryRouterProtocol {
  var router: any Meals.RouterProtocol = MockRouterProtocol()
  private(set) var values: [any Hashable] = []
  
  func push(destination: Meals.CategoryRoutes) {
    values.append(destination)
  }
  
  func pop() {
    values.append("pop")
  }
  
  func popToRootView() {
    values.append("popToRootView")
  }
}
