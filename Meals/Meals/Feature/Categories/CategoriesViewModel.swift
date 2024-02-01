//
//  CategoriesViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Foundation

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
