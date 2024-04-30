//
//  ImageLoader.swift
//  Meals
//
//  Created by Dipen Panchasara on 21/02/2024.
//

import Foundation
import UIKit
import SwiftUI

struct CacheManager {
  private static let maxCacheCapacity = 1024 * 1024 * 5
  private static let tempDirectoryURL = URL(string: NSTemporaryDirectory())
  let cache: URLCache

  init(
    cacheCapacity: Int = maxCacheCapacity,
    cacheDirectoryURL: URL? = tempDirectoryURL
  ) {
    cache = URLCache(
      memoryCapacity: cacheCapacity,
      diskCapacity: cacheCapacity,
      directory: cacheDirectoryURL
    )
  }

  func cachedImage(for urlRequest: URLRequest) -> UIImage? {
    if 
      let response = cachedResponse(for: urlRequest),
      let cachedImage = UIImage(data: response.data) 
    {
      return cachedImage
    }
    return nil
  }

  func cachedResponse(for urlRequest: URLRequest) -> CachedURLResponse? {
    cache.cachedResponse(for: urlRequest)
  }
  
  func clearCache() {
    cache.removeAllCachedResponses()
  }
}

actor ImageLoader {
  private var session: URLSession
  private let imageCache: CacheManager
//  private var images: [URLRequest: LoaderStatus] = [:]

  init(cache: CacheManager = CacheManager()) {
    self.imageCache = cache
    imageCache.clearCache()
    let configuration = URLSessionConfiguration.default
    configuration.urlCache = imageCache.cache
    configuration.requestCachePolicy = .returnCacheDataElseLoad
    session = URLSession(configuration: configuration)
  }
  
  public func fetch(_ url: URL) async throws -> UIImage {
    let request = URLRequest(url: url)
    return try await fetch(request)
  }

  public func fetch(_ urlRequest: URLRequest) async throws -> UIImage {
    if let cachedImage = imageCache.cachedImage(for: urlRequest) {
      return cachedImage
    }
    let (imageData, _) = try await session.data(for: urlRequest)
    let image = UIImage(data: imageData)!
    return image
  }
}

//private extension ImageLoader {
//  enum LoaderStatus {
//    case inProgress(Task<UIImage, Error>)
//    case fetched(UIImage)
//  }
//}

struct ImageLoaderKey: EnvironmentKey {
  static let defaultValue = ImageLoader()
}

extension EnvironmentValues {
  var imageLoader: ImageLoader {
    get { self[ImageLoaderKey.self] }
    set { self[ImageLoaderKey.self ] = newValue}
  }
}
