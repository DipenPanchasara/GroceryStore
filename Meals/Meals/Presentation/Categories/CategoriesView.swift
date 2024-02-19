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
        case .idle:
          EmptyView()
        case .loading:
          loadingView()
        case .loaded(let viewModel):
          list(categories: viewModel.categories)
        case .failed(let errorModel):
          ErrorView(viewModel: errorModel) {
            Task {
              await viewModel.onRetryTap()
            }
          }
      }
    }
    .background(Color.white)
    .withCategoryRoutes(router: viewModel.router)
    .listStyle(.plain)
    .task {
      await viewModel.onAppear()
    }
    .navigationBarTitle(
      "Categories",
      displayMode: .inline
    )
    .navigationBarTitleDisplayMode(.inline)
    .refreshable {
      Task {
        await viewModel.onRetryTap()
      }
    }
    .toolBarStyle()
  }
  
  private func loadingView() -> some View {
    HStack {
      ProgressView()
    }
  }

  private func list(categories: [CategoryModel]) -> some View {
    List(categories,
         rowContent: {
      categoryModel in
      CategoryCard(
        categoryModel: categoryModel
      )
      .listRowBackground(Color.clear)
      .listRowSeparator(.hidden)
      .onTapGesture {
        viewModel.onSelect(category: categoryModel)
      }
    })
  }
}

#if DEBUG
struct CategoriesView_Previews: PreviewProvider {
  enum MockError: Error {
    case failed
  }

  static let categoryRouter = CategoryRouter(router: Router(path: NavigationPath()))
  static let viewModel = CategoriesViewModel(
    useCase: MockCategoriesUseCase(
      categories: .mock
    ),
    router: categoryRouter
  )

  static let failedViewModel = CategoriesViewModel(
    useCase: MockCategoriesUseCase(
      error: MockError.failed
    ),
    router: categoryRouter
  )
  
  static var previews: some View {
    Group {
      NavigationStack {
        CategoriesView(viewModel: viewModel)
          .task {
            await viewModel.onAppear()
          }
          .preferredColorScheme(.dark)
          .previewDisplayName("Categories_Success")
      }
      NavigationStack {
        CategoriesView(viewModel: failedViewModel)
          .task {
            await failedViewModel.onAppear()
          }
          .preferredColorScheme(.dark)
          .previewDisplayName("Categories_failed")
      }
    }
  }
}

struct MockCategoryRouter: CategoryFlowRouter {
  func push(destination: CategoryRouter.Route) {}
  
  func pop() {}
  
  func popToRootView() {}
  
  var router: Router
}
#endif
