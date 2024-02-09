//
//  Categories.swift
//  Meals
//
//  Created by Dipen Panchasara on 29/01/2024.
//

import SwiftUI

struct CategoriesView: View {
  @ObservedObject var viewModel: CategoriesViewModel
  var body: some View {
    NavigationStack {
      Group {
        switch viewModel.loadingState {
          case .idle:
            EmptyView()
          case .loading:
            loadingView()
          case .loaded(let viewModel):
            list(categories: viewModel.categories)
          case .failed(let errorMessage):
            errorView(message: errorMessage)
        }
      }
      .task {
        await viewModel.onAppear()
      }
      .background(Color.white)
      .listStyle(.plain)
      .navigationBarTitle(
        "Categories",
        displayMode: .inline
      )
      .navigationBarTitleDisplayMode(.inline)
      .toolbarColorScheme(
        .dark,
        for: .navigationBar
      )
      .toolbarBackground(
        Color.pink,
        for: .navigationBar
      )
      .toolbarBackground(
        .visible,
        for: .navigationBar
      )
      .edgesIgnoringSafeArea(.bottom)
    }
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
    })
  }
  
  private func errorView(message: String) -> some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        Text(message)
          .font(.headline)
          .fontWeight(.bold)
          .foregroundStyle(.black)
        Spacer()
      }
      Button("Retry", action: {
        Task {
          await viewModel.onAppear()
        }
      })
      .bold()
      .foregroundColor(.white)
      .padding(8)
      .background(
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .stroke(.white, lineWidth: 1)
          .fill(.pink)
      )
      Spacer()
    }
  }
}

#if DEBUG
struct CategoriesView_Previews: PreviewProvider {
  enum MockError: Error {
    case failed
  }

  static let viewModel = CategoriesViewModel(
    useCase: MockCategoriesUseCase(
      categories: .mock
    )
  )

  static let failedViewModel = CategoriesViewModel(
    useCase: MockCategoriesUseCase(
      error: MockError.failed
    )
  )
  
  static var previews: some View {
    Group {
      CategoriesView(viewModel: viewModel)
        .task {
          await viewModel.onAppear()
        }
        .preferredColorScheme(.dark)
        .previewDisplayName("Categories_Success")
      CategoriesView(viewModel: failedViewModel)
        .task {
          await failedViewModel.onAppear()
        }
        .preferredColorScheme(.dark)
        .previewDisplayName("Categories_failed")
    }
  }
}
#endif
