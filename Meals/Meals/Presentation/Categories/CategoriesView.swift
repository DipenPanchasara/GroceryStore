//
//  Categories.swift
//  Meals
//
//  Created by Dipen Panchasara on 29/01/2024.
//

import SwiftUI

struct CategoriesView: View {
  @StateObject var viewModel: CategoriesViewModel

  var body: some View {
    Group {
      switch viewModel.loadingState {
        case .idle, .loading:
          LoadingView()
        case .loaded(let viewModel):
          gridView(categories: viewModel.categories)
        case .failed(let errorModel):
          ErrorView(viewModel: errorModel) {
            viewModel.onRetryTap()
          }
      }
    }
    .disabled(viewModel.loadingState.isLoading)
    .background(Color.white)
    .withCategoryRoutes(categoryViewModelFactory: viewModel.categoryViewModelFactory)
    .listStyle(.plain)
    .task {
      viewModel.loadData()
    }
    .navigationBarTitle(
      "Categories",
      displayMode: .inline
    )
    .navigationBarTitleDisplayMode(.inline)
    .refreshable {
      viewModel.onRetryTap()
    }
    .toolBarStyle()
  }

  private func gridView(categories: [CategoryModel]) -> some View {
    ScrollView {
      LazyVGrid(columns: viewModel.gridColumns(), spacing: .spacing.standard) {
        ForEach(categories, id: \.self) { category in
          VStack(spacing: .zero) {
            if let thumbnailURL = category.thumbnailURL {
              RemoteImageView(source: thumbnailURL)
                .aspectRatio(contentMode: .fill)
            }
            Text(category.name)
              .font(.title3)
              .bold()
              .multilineTextAlignment(.center)
              .foregroundStyle(Color.pink)
              .padding(.padding.standard)
          }
          .frame(maxHeight: viewModel.itemWidth)
          .background(.white)
          .cornerRadius(.radius.view)
          .onTapGesture {
            viewModel.onSelect(category: category)
          }
        }
      }
      .padding(.padding.standard)
    }
    .backgroundColor()
  }
}

#if DEBUG
struct CategoriesView_Previews: PreviewProvider {
  static var previews: some View {
    previewViews
  }
}
#endif
