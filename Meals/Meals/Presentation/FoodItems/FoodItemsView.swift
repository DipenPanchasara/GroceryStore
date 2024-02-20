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
          loadingView()
        case .loaded(let viewModel):
          list(items: viewModel.foodItems)
        case .failed(let errorModel):
          ErrorView(viewModel: errorModel) {
            Task {
              await viewModel.onRetryTap()
            }
          }
      }
    }
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
    .toolBarStyle(showBackButton: true) {
      viewModel.onBackTap()
    }
  }
  
  private func loadingView() -> some View {
    HStack {
      ProgressView()
    }
  }
  
  private func list(items: [FoodItemModel]) -> some View {
    List(items) { item in
      Text(item.name)
    }
  }
}
/*
#Preview {
  FoodItemsView(
    viewModel: FoodItemsViewModel(
      categoryName: "any",
      useCase: FoodItemsUseCase(),
      categoryRouter: CategoryRouter(
        router: Router(
          path: NavigationPath()
        )
      )
    )
  )
}

#if DEBUG
struct FoodItemsView_Previews: PreviewProvider {
  enum MockError: Error {
    case failed
  }
  
  static let categoryRouter = CategoryRouter(router: Router(path: NavigationPath()))
  static let viewModel = FoodItemsViewModel(
    categoryName: "any",
    useCase: FoodItemsUseCase(),
    categoryRouter: categoryRouter
  )
  
  static var previews: some View {
    Group {
      NavigationStack {
        FoodItemsView(viewModel: viewModel)
          .task {
            await viewModel.onAppear()
          }
          .preferredColorScheme(.dark)
          .previewDisplayName("Categories_Success")
      }
//      NavigationStack {
//        CategoriesView(viewModel: failedViewModel)
//          .task {
//            await failedViewModel.onAppear()
//          }
//          .preferredColorScheme(.dark)
//          .previewDisplayName("Categories_failed")
//      }
    }
  }
}
#endif
*/
