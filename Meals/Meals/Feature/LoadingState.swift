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
  case failed(String)
}
