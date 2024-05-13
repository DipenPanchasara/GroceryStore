//
//  FoodItemsView.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import SwiftUI

struct FoodItemsView: View {
  @StateObject var viewModel: FoodItemsViewModel

  var body: some View {
    Group {
      switch viewModel.loadingState {
        case .idle, .loading:
          LoadingView()
        case .loaded(let viewModel):
          list(items: viewModel.foodItems)
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
    .toolbar(.hidden, for: .tabBar)
    .navigationBarTitleDisplayMode(.inline)
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
            .padding(.padding.standard)
        }
      }
      .background(.white)
      .cornerRadius(.radius.view)
      .padding(.padding.standard)
      .shadow(color: .gray, radius: .padding.standard)
      .onTapGesture {
        viewModel.onFoodItemTap(item: item)
      }
      .listRowBackground(Color.clear)
      .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
  }
  
  private func gridView(items: [FoodItemModel]) -> some View {
    ScrollView {
      LazyVGrid(columns: viewModel.gridColumns(), spacing: .spacing.standard) {
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
                .padding(.padding.standard)
            }
          }
          .background(.white)
          .cornerRadius(.radius.view)
          .padding(.padding.standard)
          .shadow(color: .gray, radius: .padding.standard)
          .onTapGesture {
            viewModel.onFoodItemTap(item: item)
          }
        }
      }
    }
    .backgroundColor()
  }
}

#if DEBUG
struct FoodItemsView_Previews: PreviewProvider {
  static var previews: some View {
    previewViews
  }
}
#endif
