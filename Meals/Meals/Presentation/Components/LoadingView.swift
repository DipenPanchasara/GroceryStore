//
//  IdleView.swift
//  Meals
//
//  Created by Dipen Panchasara on 06/03/2024.
//

import Foundation

import SwiftUI
struct LoadingView: View {
  
  private let emoji = ["🍇","🍈","🍉","🍊","🍋","🍌","🍍","🥭","🍎","🍐","🍗","🍔","🍟","🍕","🌭","🥪","🌮","🥙","🧆","🥗","🍦","🍧","🍨","🍩","🍪","🎂"]
  
  var body: some View {
    TimelineView(.periodic(from: .now, by: 0.2)) { timeline in
      HStack(spacing: 120) {
        let randomEmoji = emoji.randomElement() ?? ""
        Text(randomEmoji)
          .font(.largeTitle)
          .scaleEffect(4.0)
      }
    }
  }
}

struct IdleView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView()
  }
}
