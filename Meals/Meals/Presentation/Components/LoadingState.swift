//
//  LoadingState.swift
//  Meals
//
//  Created by Dipen Panchasara on 09/02/2024.
//

import Foundation

enum LoadingState<ViewModel: Equatable>: Equatable {
  case idle
  case loading
  case loaded(model: ViewModel)
  case failed(model: ErrorModel)
  
  var isLoading: Bool {
    self == .loading
  }
  
  var canLoad: Bool {
    switch self {
      case .idle, .failed:
        return true
      case .loading, .loaded:
        return false
    }
  }
}
