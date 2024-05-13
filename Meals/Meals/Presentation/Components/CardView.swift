//
//  CardView.swift
//  Meals
//
//  Created by Dipen Panchasara on 26/02/2024.
//

import SwiftUI

struct CardView: View {
  let name: String
  let thumbURL: URL?
  
  var body: some View {
    ZStack(alignment: .bottom) {
      HStack(spacing: .zero) {
        if let thumbnailURL = thumbURL {
          RemoteImageView(source: thumbnailURL)
        } else {
          Image("placeholder", bundle: .main)
            .resizable()
        }
      }
      VStack(spacing: .zero) {
        HStack(spacing: .zero) {
          Text(name)
            .font(.title)
            .bold()
            .foregroundStyle(Color.pink)
          Spacer()
        }
      }
      .padding(.vertical, 8)
      .padding(.horizontal, 16)
      .background(Color.white.opacity(0.6))
    }
    .background(Color.white)
    .cornerRadius(16)
    .frame(maxHeight: 200)
    .shadow(color: .gray, radius: 4)
  }
}
