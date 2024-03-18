//
//  FoodItemsView.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import SwiftUI

extension CGFloat {
  enum spacing {
    static let standard: CGFloat = 8
  }

  
  enum padding {
    static let standard: CGFloat = 8
  }

  enum radius {
    static let view: CGFloat = 10
  }
}

struct FoodItemsView: View {
  @ObservedObject var viewModel: FoodItemsViewModel

  var body: some View {
    Group {
      switch viewModel.loadingState {
        case .idle, .loading:
          LoadingView()
        case .loaded(let viewModel):
//          gridView(items: viewModel.foodItems)
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

//      CardView(name: item.name, thumbURL: item.thumbURL)
//        .listRowBackground(Color.clear)
//        .listRowSeparator(.hidden)
//        .onTapGesture {
//          viewModel.onFoodItemTap(item: item)
//        }
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
