//
//  Router.swift
//  Meals
//
//  Created by Dipen Panchasara on 16/02/2024.
//

import SwiftUI
import Combine

protocol RouterProtocol {
  func pop()
  func popToRootView()
}

final class Router: ObservableObject, RouterProtocol {
  @Published var path: NavigationPath
//  var anycancellable: AnyCancellable?

  init(path: NavigationPath) {
    self.path = path
//    anycancellable = $path.sink { path in
//      print(path)
//      print(path.count)
//    }
  }
  
  func push(destination: any Hashable) {
    path.append(destination)
  }
  
  func pop() {
    path.removeLast()
  }
  
  func popToRootView() {
    path = NavigationPath()
  }
}
