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
        List(viewModel.categories, rowContent: { categoryModel in
          CategoryCard(categoryModel: categoryModel)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        })
        .background(Color.black)
        .listStyle(.plain)
        .navigationBarTitle("Categories", displayMode: .inline)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(Color.pink, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .edgesIgnoringSafeArea(.bottom)
        .task {
          await viewModel.onAppear()
        }
      }
    }
}

#if DEBUG
#Preview {
  CategoriesView(
    viewModel: CategoriesViewModel(
      useCase: MockCategoriesUseCase(
        categories: .mock
      )
    )
  )
  .preferredColorScheme(.dark)
  
}
#endif
