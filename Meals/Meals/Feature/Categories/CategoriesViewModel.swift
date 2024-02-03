//
//  CategoriesViewModel.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Foundation

class CategoriesViewModel: ObservableObject {
  private let useCase: CategoriesUseCaseProtocol
  @Published var categories: [CategoryModel] = []
  
  init(useCase: CategoriesUseCaseProtocol) {
    self.useCase = useCase
  }
  
  @MainActor
  func onAppear() async {
    do {
      categories = try await useCase.fetchCategories()
    } catch {
      print(error)
    }
  }
}
