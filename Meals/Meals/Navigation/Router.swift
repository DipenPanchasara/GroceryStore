//
//  Router.swift
//  Meals
//
//  Created by Dipen Panchasara on 16/02/2024.
//

import SwiftUI

class Router: ObservableObject {
  @Published var path: NavigationPath
  
  init(path: NavigationPath) {
    self.path = path
  }
  
  func push(destination: any Hashable) {
    path.append(destination)
  }
  
  func pop() {
    path.removeLast()
  }
  
  func popToRootView() {
    print(path.count)
  }
}

protocol FlowRouter {
//  var router: Router { get }
}
