//
//  RemoteImageView.swift
//  Meals
//
//  Created by Dipen Panchasara on 23/02/2024.
//

import SwiftUI

struct RemoteImageView: View {
  private let source: URLRequest
  @State private var image: UIImage?

  @Environment(\.imageLoader) private var imageLoader

  init(source: URL) {
    self.init(source: URLRequest(url: source))
  }

  init(source: URLRequest) {
    self.source = source
  }

  var body: some View {
    Group {
      if let image = image {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .animation(.easeOut, value: image)
      } else {
        Rectangle()
          .fill(Color.white)
          .overlay {
            ProgressView()
              .foregroundStyle(Color.pink)
          }
      }
    }
    .background(Color.white)
    .task {
      await loadImage(at: source)
    }
  }

  func loadImage(at source: URLRequest) async {
    do {
      image = try await imageLoader.fetch(source)
    } catch {
      print(error)
    }
  }
}
