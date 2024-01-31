//
//  Categories.swift
//  Meals
//
//  Created by Dipen Panchasara on 29/01/2024.
//

import SwiftUI

struct Categories: View {
  let viewModel = ViewModel(network: NetworkManager())
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
          await viewModel.onAppear()
        }
    }
}

#Preview {
  Categories()
}

class ViewModel {
  let network: NetworkProvider
  var categories: [CategoriesData.Category] = []

  init(network: NetworkProvider) {
    self.network = network
  }
  
  func onAppear() async {
    do {
      let categoriesData: CategoriesData = try await network.execute(request: URLRequest(url: URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!))
      categories = categoriesData.categories
    } catch {
      print(error)
    }
  }
}

extension ViewModel {
  struct CategoriesData: Decodable {
    let categories: [Category]
    
    struct Category: Decodable, Equatable {
      let idCategory: String
      let strCategory: String
      let strCategoryThumb: String?
    }
  }
}
/*
 
 API for Meals
 
 https://www.themealdb.com/api.php
 
 */
