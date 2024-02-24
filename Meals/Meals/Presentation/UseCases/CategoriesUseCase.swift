//
//  CategoriesUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Foundation
import Combine
import SwiftUI

protocol CategoriesUseCaseProtocol {
  var dataStream: PassthroughSubject<[CategoryModel], Never> { get }
  var errorStream: PassthroughSubject<Error, Never> { get }
  func fetchCategories() async
}

struct CategoriesUseCase: CategoriesUseCaseProtocol {
  private let categoryRepository: CategoryRepositoryProtocol
  let dataStream: PassthroughSubject<[CategoryModel], Never> = PassthroughSubject()
  let errorStream: PassthroughSubject<Error, Never> = PassthroughSubject()

  init(categoryRepository: CategoryRepositoryProtocol) {
    self.categoryRepository = categoryRepository
  }

  func fetchCategories() async {
    do {
      let categoryModels = try await categoryRepository.allCategories()
        .map({ map(categoryData: $0) })
        .sorted(by: { $0.name < $1.name })
      dataStream.send(categoryModels)
    } catch {
      errorStream.send(error)
    }
  }
}

private extension CategoriesUseCase {
  func map(categoryData: CategoriesData.Category) -> CategoryModel {
    var thumbnailURL: URL?
    if let urlString = categoryData.strCategoryThumb {
      thumbnailURL = URL(string: urlString)
    }

    return CategoryModel(
      id: categoryData.idCategory,
      name: categoryData.strCategory,
      thumbnailURL: thumbnailURL
    )
  }
}
