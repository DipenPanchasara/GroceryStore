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
//          list(categories: viewModel.categories)
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
      viewModel.onAppear()
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

  private func list(categories: [CategoryModel]) -> some View {
    List(categories,
         rowContent: {
      categoryModel in
      CardView(
        name: categoryModel.name,
        thumbURL: categoryModel.thumbnailURL
      )
      .listRowBackground(Color.clear)
      .listRowSeparator(.hidden)
      .onTapGesture {
        viewModel.onSelect(category: categoryModel)
      }
    })
  }
  
  private func gridView(categories: [CategoryModel]) -> some View {
    ScrollView{
      LazyVGrid(columns: viewModel.gridColumns(), spacing: viewModel.padding) {
        ForEach(categories, id: \.self) { category in
          ZStack(alignment: .top) {
            Rectangle()
              .fill(.white)
            VStack(spacing: .zero) {
              if let thumbnailURL = category.thumbnailURL {
                RemoteImageView(source: thumbnailURL)
              }
              Text(category.name)
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.pink)
                .padding(.top, 8)
                .padding(.horizontal, 4)
            }
            .frame(width: viewModel.itemWidth, height: viewModel.itemWidth)
          }
          .background(.white)
          .cornerRadius(10)
          .onTapGesture {
            viewModel.onSelect(category: category)
          }
        }
      }
      .padding(.vertical, viewModel.padding)
    }
    .background(.gray.opacity(0.2))
  }
}

#if DEBUG
struct CategoriesView_Previews: PreviewProvider {
  static var previews: some View {
    previewViews
  }
}
#endif
