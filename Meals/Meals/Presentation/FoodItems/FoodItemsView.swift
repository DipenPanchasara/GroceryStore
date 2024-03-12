//
//  FoodItemsView.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import SwiftUI

struct FoodItemsView: View {
  @ObservedObject var viewModel: FoodItemsViewModel

  var body: some View {
    Group {
      switch viewModel.loadingState {
        case .idle, .loading:
          LoadingView()
        case .loaded(let viewModel):
          list(items: viewModel.foodItems)
        case .failed(let errorModel):
          ErrorView(viewModel: errorModel) {
            await viewModel.onRetryTap()
          }
      }
    }
    .background(Color.white)
    .navigationBarTitle(
      viewModel.navigationTitle,
      displayMode: .inline
    )
    .navigationBarTitleDisplayMode(.inline)
//    .redacted(if: viewModel.loadingState.isLoading)
    .task {
      await viewModel.onAppear()
    }
    .refreshable {
      Task {
        await viewModel.onRetryTap()
      }
    }
    .toolBarStyle(showBackButton: true)
  }

  private func list(items: [FoodItemModel]) -> some View {
    List(items) { item in
      CardView(name: item.name, thumbURL: item.thumbURL)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .onTapGesture {
          viewModel.onFoodItemTap(item: item)
        }
    }
    .listStyle(.plain)
  }
}

#if DEBUG
struct FoodItemsView_Previews: PreviewProvider {
  static var previews: some View {
    previewViews
  }
}
#endif
