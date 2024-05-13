//
//  RootView.swift
//  Meals
//
//  Created by Dipen Panchasara on 04/02/2024.
//

import SwiftUI

struct RootView: View {
  @StateObject var viewModel: RootViewModel

  var body: some View {
    TabView {
      NavigationStack(path: viewModel.$router.path) {
        CategoriesView(
          viewModel: viewModel.categoryViewModel()
        )
      }
      .tabItem {
        VStack {
          Image(systemName: "list.bullet.clipboard")
          Text("Categories") }
      }
      NavigationStack(path: viewModel.$router.path) {
        List(0...4, id: \.self) {
          Text("\($0)")
        }
        .navigationTitle("Favourite")
        .toolBarStyle()
      }
      .tabItem {
        VStack {
          Image(systemName: "star")
          Text("Favourite")
        }
      }
    }
  }
}

#if DEBUG
struct RootView_Previews: PreviewProvider {
  static let router = Router(path: NavigationPath())

  static var previews: some View {
    RootView(
      viewModel: RootViewModel(
        scheme: "https",
        baseURLString: "www.test.com",
        router: router
      )
    )
    .previewDisplayName("RootView")
  }
}
#endif
