//
//  PublisherSpy.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 16/05/2024.
//

import Foundation
import Combine

final class PublisherSpy<T> {
  private var cancellable: AnyCancellable?
  private(set) var values: [T] = []
  private(set) var callCounts: Int = 0
  
  init(_ publisher: AnyPublisher<Result<[T], Error>, Never>) {
    cancellable = publisher
      .sink(receiveValue: { [weak self] result in
        self?.callCounts += 1
        switch result {
          case .success(let items):
            self?.values.append(contentsOf: items)
          case .failure(_):
            break
        }
      })
  }
}
