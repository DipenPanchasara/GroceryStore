//
//  RootViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 04/02/2024.
//

import SwiftUI

class RootViewModel: ObservableObject {
  private let sessionConfiguration = URLSessionConfiguration.default

  private(set) var scheme: String
  private(set) var baseURLString: String
  private(set) var session: URLSession
  private(set) var categoryVMFactory: CategoryViewModelFactoryProtocol
  private let networkManager: NetworkProvider

  @ObservedObject private(set) var router: Router

  init(
    scheme: String,
    baseURLString: String,
    router: Router
  ) {
    self.scheme = scheme
    self.baseURLString = baseURLString
    self.sessionConfiguration.timeoutIntervalForRequest = 60
    self.sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    self.session = URLSession(configuration: sessionConfiguration)
    self.router = router
    self.networkManager = NetworkManager(
      scheme: scheme,
      baseURLString: baseURLString,
      session: session
    )
    self.categoryVMFactory = CategoryViewModelFactory(
      categoryRepository: CategoryRepository(
        networkManager: networkManager,
        decoder: ResponseDecoder()
      ),
      categoryRouter: CategoryRouter(router: router)
    )
  }

  func categoryViewModel() -> CategoriesViewModel {
    categoryVMFactory.categoryListViewModel()
  }
}
