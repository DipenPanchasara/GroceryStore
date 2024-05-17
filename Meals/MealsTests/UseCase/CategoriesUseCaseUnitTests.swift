//
//  CategoriesUseCaseUnitTests.swift
//  MealsTests
//
//  Created by Dipen Panchasara on 17/05/2024.
//

@testable import Meals
import Combine
import Cuckoo
import XCTest

final class CategoriesUseCaseUnitTests: XCTestCase {
  func testFetchCategoriesWithPublisher() {
    let subject: PassthroughSubject<[CategoryEntity], Error> = PassthroughSubject()

    let repository = MockCategoryRepositoryProtocol()
    stub(repository) {
      $0.allCategories()
        .thenReturn(subject.eraseToAnyPublisher())
    }
    let sut = CategoriesUseCase(categoryRepository: repository)
    let spy = PublisherSpy(sut.publisher)
    XCTAssertEqual(spy.callCounts, 1)
    XCTAssertEqual(spy.error as? CategoriesUseCase.UseCaseError, CategoriesUseCase.UseCaseError.initialState)
    sut.fetchCategories()
    subject.send(.mock)
    subject.send(completion: .finished)
    XCTAssertEqual(spy.callCounts, 2)
    XCTAssertNil(spy.error)
    XCTAssertEqual(spy.values.map(\.name), [CategoryEntity].mock.map(\.name))
    XCTAssertEqual(spy.values.count, 5)
  }
  
  func testFetchCategoriesWithPublisherWhenRepositoryThrows() {
    let subject: PassthroughSubject<[CategoryEntity], Error> = PassthroughSubject()
    
    let repository = MockCategoryRepositoryProtocol()
    stub(repository) {
      $0.allCategories()
        .thenReturn(subject.eraseToAnyPublisher())
    }
    let sut = CategoriesUseCase(categoryRepository: repository)
    let spy = PublisherSpy(sut.publisher)
    XCTAssertEqual(spy.callCounts, 1)
    XCTAssertEqual(spy.error as? CategoriesUseCase.UseCaseError, CategoriesUseCase.UseCaseError.initialState)
    sut.fetchCategories()
    subject.send(completion: .failure(MockError.repositoryFailed))
    XCTAssertEqual(spy.callCounts, 2)
    XCTAssertEqual(spy.error as? MockError, MockError.repositoryFailed)
    XCTAssertTrue(spy.values.isEmpty)
  }
  
  func testFetchCategoriesWithAsyncAwait() async {
    let subject: CurrentValueSubject<[CategoryEntity], Error> = CurrentValueSubject(.mock)
    
    let repository = MockCategoryRepositoryProtocol()
    stub(repository) {
      $0.allCategories()
        .thenReturn(subject.eraseToAnyPublisher())
    }
    let sut = CategoriesUseCase(categoryRepository: repository)
    let result = await sut.fetchCategories()
    switch result {
      case .success(let entities):
        XCTAssertEqual(entities.count, 5)
        XCTAssertEqual(entities.map(\.name), [CategoryEntity].mock.map(\.name))
      case .failure(_):
        XCTFail("Shouldn't fail")
    }
  }
  
  func testFetchCategoriesWithAsyncAwaitWhenRepositoryThrows() async {
    let subject: CurrentValueSubject<[CategoryEntity], Error> = CurrentValueSubject([])
    
    let repository = MockCategoryRepositoryProtocol()
    stub(repository) {
      $0.allCategories()
        .thenReturn(subject.eraseToAnyPublisher())
    }
    subject.send(completion: .failure(MockError.repositoryFailed))
    let sut = CategoriesUseCase(categoryRepository: repository)
    let result = await sut.fetchCategories()
    switch result {
      case .success(_):
        XCTFail("Shouldn't succeed")
      case .failure(let failure):
        XCTAssertEqual(failure as? MockError, MockError.repositoryFailed)
    }
  }
}

// MARK: - Mocks

private extension [CategoryEntity] {
  static let mock: [CategoryEntity] = [CategoryEntity].init(repeating: CategoryEntity(id: UUID().uuidString, name: "anyName", thumbURLString: "anyURLString"), count: 5)
}

private extension CategoriesUseCaseUnitTests {
  enum MockError: Error {
    case repositoryFailed
  }
}
