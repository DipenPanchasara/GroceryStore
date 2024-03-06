//
//  ImageLoader.swift
//  Meals
//
//  Created by Dipen Panchasara on 21/02/2024.
//

import Foundation
import UIKit
import SwiftUI

actor ImageLoader {
  private var images: [URLRequest: LoaderStatus] = [:]

  public func fetch(_ url: URL) async throws -> UIImage {
    let request = URLRequest(url: url)
    return try await fetch(request)
  }

  public func fetch(_ urlRequest: URLRequest) async throws -> UIImage {
    if let status = images[urlRequest] {
      switch status {
        case .fetched(let image):
          return image
        case .inProgress(let task):
          return try await task.value
      }
    }

    let task: Task<UIImage, Error> = Task {
      let (imageData, _) = try await URLSession.shared.data(for: urlRequest)
      let image = UIImage(data: imageData)!
      images[urlRequest] = .fetched(image)
      return image
    }

    images[urlRequest] = .inProgress(task)

    let image = try await task.value

    images[urlRequest] = .fetched(image)

    return image
  }
}

private extension ImageLoader {
  enum LoaderStatus {
    case inProgress(Task<UIImage, Error>)
    case fetched(UIImage)
  }
}

struct ImageLoaderKey: EnvironmentKey {
  static let defaultValue = ImageLoader()
}

extension EnvironmentValues {
  var imageLoader: ImageLoader {
    get { self[ImageLoaderKey.self] }
    set { self[ImageLoaderKey.self ] = newValue}
  }
}
