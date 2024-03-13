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
          gridView(items: viewModel.foodItems)
//          list(items: viewModel.foodItems)
        case .failed(let errorModel):
          ErrorView(viewModel: errorModel) {
            viewModel.onRetryTap()
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
      viewModel.loadData()
    }
    .refreshable {
        viewModel.onRetryTap()
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
  
  private func gridView(items: [FoodItemModel]) -> some View {
    ScrollView {
      LazyVGrid(columns: viewModel.gridColumns(), spacing: viewModel.padding) {
        ForEach(items) { item in
          ZStack(alignment: .top) {
            Rectangle()
              .fill(.white)
            VStack(spacing: .zero) {
              if let thumbnailURL = item.thumbURL {
                RemoteImageView(source: thumbnailURL)
                  .aspectRatio(contentMode: .fill)
              }
              Text(item.name)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.pink)
                .padding(8)
            }
          }
          .background(.white)
          .cornerRadius(10)
          .padding(viewModel.padding)
          .shadow(color: .gray, radius: viewModel.padding)
          .onTapGesture {
            viewModel.onFoodItemTap(item: item)
          }
        }
      }
    }
    .background(.gray.opacity(0.2))
  }
}

#if DEBUG
struct FoodItemsView_Previews: PreviewProvider {
  static var previews: some View {
    previewViews
  }
}
#endif
