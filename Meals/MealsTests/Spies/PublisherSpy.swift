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
  private(set) var error: Error?
  
  init(_ publisher: AnyPublisher<Result<[T], Error>, Never>) {
    cancellable = publisher
      .sink(receiveValue: { [weak self] result in
        self?.callCounts += 1
        switch result {
          case .success(let items):
            self?.values.append(contentsOf: items)
            self?.error = nil
          case .failure(let failure):
            self?.error = failure
        }
      })
  }
  
  init(
    publisher: AnyPublisher<T, Never>,
    valueChange: ((_ values: [T]) -> Void)? = nil
  ) {
    cancellable = publisher
      .sink(receiveValue: { [weak self] value in
        print("Spy received: \(value)")
        self?.callCounts += 1
        self?.values.append(value)
        valueChange?(self?.values ?? [])
      })
  }
}
