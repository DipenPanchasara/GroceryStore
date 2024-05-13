//
//  Router.swift
//  Meals
//
//  Created by Dipen Panchasara on 16/02/2024.
//

import SwiftUI
import Combine

protocol RouterProtocol {
  func push(destination: any Hashable)
  func pop()
  func popToRootView()
}

final class Router: ObservableObject, RouterProtocol {
  @Published var path: NavigationPath

  init(path: NavigationPath) {
    self.path = path
  }

  func push(destination: any Hashable) {
    path.append(destination)
  }

  func pop() {
    path.removeLast(path.count)
  }

  func popToRootView() {
    path = NavigationPath()
  }
}

protocol ModuleRouter {
  var router: RouterProtocol { get }
}
