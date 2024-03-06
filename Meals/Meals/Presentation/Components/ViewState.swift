//
//  ViewState.swift
//  Meals
//
//  Created by Dipen Panchasara on 09/02/2024.
//

import Foundation

enum ViewState<ViewModel: Equatable>: Equatable {
  case idle
  case loading(model: ViewModel)
  case loaded(model: ViewModel)
  case failed(model: ErrorModel)
  
  var isLoading: Bool {
    switch self {
      case .loading:
        return true
      case .idle, .loaded, .failed:
        return false
    }
  }
  
  var canReload: Bool {
    switch self {
      case .loading:
        return false
      case .idle, .loaded, .failed:
        return true
    }
  }
}
