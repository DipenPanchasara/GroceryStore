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
        case .idle:
          EmptyView()
        case .loading:
          list(items: .mock)
        case .loaded(let viewModel):
          list(items: viewModel.foodItems)
        case .failed(let errorModel):
          ErrorView(viewModel: errorModel) {
            await viewModel.onRetryTap()
          }
      }
    }
    .redacted(if: viewModel.loadingState.isLoading)
    .background(Color.white)
    .listStyle(.plain)
    .task {
      await viewModel.onAppear()
    }
    .navigationBarTitle(
      viewModel.navigationTitle,
      displayMode: .inline
    )
    .navigationBarTitleDisplayMode(.inline)
    .refreshable {
      Task {
        await viewModel.onRetryTap()
      }
    }
    .toolBarStyle(showBackButton: true)
  }

  private func loadingView() -> some View {
    HStack {
      ProgressView()
    }
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
  }
}

#if DEBUG
struct FoodItemsView_Previews: PreviewProvider {
  enum MockError: Error {
    case failed
  }

  static let categoryRouter = CategoryRouter(router: Router(path: NavigationPath()))

  static var previews: some View {
    Group {
      NavigationStack {
        FoodItemsView(
          viewModel: FoodItemsViewModel(categoryName: "any", useCase: MockFoodItemsUseCase(foodItems: .mock), categoryRouter: categoryRouter)
        )
        .preferredColorScheme(.dark)
        .previewDisplayName("Success")
      }
//      NavigationStack {
//        FoodItemsView(
//          viewModel: FoodItemsViewModel(categoryName: "any", useCase: MockFoodItemsUseCase(error: MockError.failed), categoryRouter: categoryRouter)
//        )
//        .preferredColorScheme(.dark)
//        .previewDisplayName("Success")
//      }
    }
  }
}
// struct FoodItemsView_Previews: PreviewProvider {
//  enum MockError: Error {
//    case failed
//  }
//
//  static let categoryRouter = CategoryRouter(router: Router(path: NavigationPath()))
//  static var previews: some View {
//    FoodItemsView(
//      viewModel: FoodItemsViewModel(
//        categoryName: "any",
//        useCase: MockFoodItemsUseCase(
//          foodItems: .mock
//        ),
//        categoryRouter: categoryRouter
//      )
//    )
//    .preferredColorScheme(.dark)
//    .previewDisplayName("FoodItemsSuccess")
//  }
// }
#endif
