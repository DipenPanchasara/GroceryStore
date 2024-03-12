//
//  LoadingView.swift
//  Meals
//
//  Created by Dipen Panchasara on 06/03/2024.
//

import Foundation

import SwiftUI
struct LoadingView: View {
  
  @StateObject var viewModel = ViewModel()
  
  var body: some View {
    HStack(alignment: .center) {
      Text(viewModel.value)
        .font(.largeTitle)
        .scaleEffect(2.0)
    }
  }
}

final class ViewModel: ObservableObject {
  @Published var value: String = ""
  private var timer: Timer?
  private let emoji = ["🍇","🍈","🍉","🍊","🍋","🍌","🍍","🥭","🍎","🍐","🍗","🍔","🍟","🍕","🌭","🥪","🌮","🥙","🧆","🥗","🍦","🍧","🍨","🍩","🍪","🎂"]

  init() {
    timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] timer in
      guard let self = self else { return }
      let randomEmoji = self.emoji.randomElement() ?? ""
      self.value += "\(randomEmoji) "
      if self.value.count == 10 {
        self.value.removeFirst(2)
      }
    }
  }
}

struct IdleView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView()
  }
}
