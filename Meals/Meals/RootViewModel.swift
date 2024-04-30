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
  private(set) var decoder: ResponseDecoderProvider
  private(set) var categoryVMFactory: CategoryViewModelFactoryProtocol
  private let networkManager: NetworkProvider
  private var requestCache: CacheManager

  @ObservedObject private(set) var router: Router

  init(
    scheme: String,
    baseURLString: String,
    router: Router,
    requestCache: CacheManager = CacheManager()
  ) {
    self.scheme = scheme
    self.baseURLString = baseURLString
    self.requestCache = requestCache
    self.sessionConfiguration.timeoutIntervalForRequest = 60
    self.sessionConfiguration.requestCachePolicy = .reloadIgnoringCacheData
    self.sessionConfiguration.urlCache = requestCache.cache
    self.session = URLSession(configuration: sessionConfiguration)
    self.decoder = ResponseDecoder()
    self.router = router
    self.networkManager = NetworkManager(
      scheme: scheme,
      baseURLString: baseURLString,
      session: session, 
      decoder: ResponseDecoder()
    )
    self.categoryVMFactory = CategoryViewModelFactory(
      categoryRepository: CategoryRepository(
        networkManager: networkManager
      ),
      foodItemRepository: FoodItemRepository(
        networkManager: networkManager
      ),
      categoryRouter: CategoryRouter(router: router)
    )
  }

  func categoryViewModel() -> CategoriesViewModel {
    categoryVMFactory.categoryListViewModel()
  }
}
