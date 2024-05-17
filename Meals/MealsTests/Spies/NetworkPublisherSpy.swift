//
//  NetworkPublisherSpy.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 16/05/2024.
//

import Combine

final class NetworkPublisherSpy<T> {
  private var cancellable: AnyCancellable?
  private(set) var values: [T] = []
  private(set) var callCounts: Int = 0
  private(set) var error: Error?
  private(set) var isCompleted: Bool = false
  
  init(_ publisher: AnyPublisher<T, Error>) {
    cancellable = publisher
      .sink(receiveCompletion: { [weak self] completion in
        switch completion {
          case .finished:
            print("Spy received: finished")
            self?.isCompleted = true
          case .failure(let failure):
            print("Spy received error: \(failure)")
            self?.error = failure
        }
      }, receiveValue: { [weak self] value in
        print("Spy received: \(value)")
        self?.values.append(value)
      })
  }
}
