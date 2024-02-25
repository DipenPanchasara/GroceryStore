// MARK: - Mocks generated from file: Meals/Navigation/CategoryRouter.swift at 2024-02-25 20:08:52 +0000

//
//  CategoryRouter.swift
//  Meals
//
//  Created by Dipen Panchasara on 16/02/2024.
//

import Cuckoo
@testable import Meals

import SwiftUI






 class MockCategoryRouterProtocol: CategoryRouterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = CategoryRouterProtocol
    
     typealias Stubbing = __StubbingProxy_CategoryRouterProtocol
     typealias Verification = __VerificationProxy_CategoryRouterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CategoryRouterProtocol?

     func enableDefaultImplementation(_ stub: CategoryRouterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func push(destination: CategoryRoutes)  {
        
    return cuckoo_manager.call(
    """
    push(destination: CategoryRoutes)
    """,
            parameters: (destination),
            escapingParameters: (destination),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.push(destination: destination))
        
    }
    
    
    
    
    
     func pop()  {
        
    return cuckoo_manager.call(
    """
    pop()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.pop())
        
    }
    
    
    
    
    
     func popToRootView()  {
        
    return cuckoo_manager.call(
    """
    popToRootView()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.popToRootView())
        
    }
    
    

     struct __StubbingProxy_CategoryRouterProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func push<M1: Cuckoo.Matchable>(destination: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CategoryRoutes)> where M1.MatchedType == CategoryRoutes {
            let matchers: [Cuckoo.ParameterMatcher<(CategoryRoutes)>] = [wrap(matchable: destination) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCategoryRouterProtocol.self, method:
    """
    push(destination: CategoryRoutes)
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func pop() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCategoryRouterProtocol.self, method:
    """
    pop()
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func popToRootView() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCategoryRouterProtocol.self, method:
    """
    popToRootView()
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_CategoryRouterProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func push<M1: Cuckoo.Matchable>(destination: M1) -> Cuckoo.__DoNotUse<(CategoryRoutes), Void> where M1.MatchedType == CategoryRoutes {
            let matchers: [Cuckoo.ParameterMatcher<(CategoryRoutes)>] = [wrap(matchable: destination) { $0 }]
            return cuckoo_manager.verify(
    """
    push(destination: CategoryRoutes)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func pop() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    pop()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func popToRootView() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    popToRootView()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class CategoryRouterProtocolStub: CategoryRouterProtocol {
    

    

    
    
    
    
     func push(destination: CategoryRoutes)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func pop()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func popToRootView()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: Meals/Navigation/Router.swift at 2024-02-25 20:08:52 +0000

//
//  Router.swift
//  Meals
//
//  Created by Dipen Panchasara on 16/02/2024.
//

import Cuckoo
@testable import Meals

import Combine
import SwiftUI






 class MockRouterProtocol: RouterProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = RouterProtocol
    
     typealias Stubbing = __StubbingProxy_RouterProtocol
     typealias Verification = __VerificationProxy_RouterProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: RouterProtocol?

     func enableDefaultImplementation(_ stub: RouterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func pop()  {
        
    return cuckoo_manager.call(
    """
    pop()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.pop())
        
    }
    
    
    
    
    
     func popToRootView()  {
        
    return cuckoo_manager.call(
    """
    popToRootView()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.popToRootView())
        
    }
    
    

     struct __StubbingProxy_RouterProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func pop() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRouterProtocol.self, method:
    """
    pop()
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func popToRootView() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRouterProtocol.self, method:
    """
    popToRootView()
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_RouterProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func pop() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    pop()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func popToRootView() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    popToRootView()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class RouterProtocolStub: RouterProtocol {
    

    

    
    
    
    
     func pop()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func popToRootView()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: Meals/NetworkManager/NetworkManager.swift at 2024-02-25 20:08:52 +0000

//
//  NetworkManager.swift
//  Meals
//
//  Created by Dipen Panchasara on 31/01/2024.
//

import Cuckoo
@testable import Meals

import Combine
import Foundation






 class MockNetworkProvider: NetworkProvider, Cuckoo.ProtocolMock {
    
     typealias MocksType = NetworkProvider
    
     typealias Stubbing = __StubbingProxy_NetworkProvider
     typealias Verification = __VerificationProxy_NetworkProvider

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: NetworkProvider?

     func enableDefaultImplementation(_ stub: NetworkProvider) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func execute(request: NetworkRequest) async throws -> NetworkResponse {
        
    return try await cuckoo_manager.callThrows(
    """
    execute(request: NetworkRequest) async throws -> NetworkResponse
    """,
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.execute(request: request))
        
    }
    
    

     struct __StubbingProxy_NetworkProvider: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func execute<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.ProtocolStubThrowingFunction<(NetworkRequest), NetworkResponse> where M1.MatchedType == NetworkRequest {
            let matchers: [Cuckoo.ParameterMatcher<(NetworkRequest)>] = [wrap(matchable: request) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNetworkProvider.self, method:
    """
    execute(request: NetworkRequest) async throws -> NetworkResponse
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_NetworkProvider: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func execute<M1: Cuckoo.Matchable>(request: M1) -> Cuckoo.__DoNotUse<(NetworkRequest), NetworkResponse> where M1.MatchedType == NetworkRequest {
            let matchers: [Cuckoo.ParameterMatcher<(NetworkRequest)>] = [wrap(matchable: request) { $0 }]
            return cuckoo_manager.verify(
    """
    execute(request: NetworkRequest) async throws -> NetworkResponse
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class NetworkProviderStub: NetworkProvider {
    

    

    
    
    
    
     func execute(request: NetworkRequest) async throws -> NetworkResponse  {
        return DefaultValueRegistry.defaultValue(for: (NetworkResponse).self)
    }
    
    
}





// MARK: - Mocks generated from file: Meals/Presentation/UseCases/CategoriesUseCase.swift at 2024-02-25 20:08:52 +0000

//
//  CategoriesUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Cuckoo
@testable import Meals

import Combine
import Foundation
import SwiftUI






 class MockCategoriesUseCaseProtocol: CategoriesUseCaseProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = CategoriesUseCaseProtocol
    
     typealias Stubbing = __StubbingProxy_CategoriesUseCaseProtocol
     typealias Verification = __VerificationProxy_CategoriesUseCaseProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CategoriesUseCaseProtocol?

     func enableDefaultImplementation(_ stub: CategoriesUseCaseProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
     var dataStream: PassthroughSubject<[CategoryModel], Never> {
        get {
            return cuckoo_manager.getter("dataStream",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.dataStream)
        }
        
    }
    
    
    
    
    
     var errorStream: PassthroughSubject<Error, Never> {
        get {
            return cuckoo_manager.getter("errorStream",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.errorStream)
        }
        
    }
    
    

    

    
    
    
    
     func fetchCategories() async {
        
    return await cuckoo_manager.call(
    """
    fetchCategories() async
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.fetchCategories())
        
    }
    
    

     struct __StubbingProxy_CategoriesUseCaseProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var dataStream: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCategoriesUseCaseProtocol, PassthroughSubject<[CategoryModel], Never>> {
            return .init(manager: cuckoo_manager, name: "dataStream")
        }
        
        
        
        
        var errorStream: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCategoriesUseCaseProtocol, PassthroughSubject<Error, Never>> {
            return .init(manager: cuckoo_manager, name: "errorStream")
        }
        
        
        
        
        
        func fetchCategories() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCategoriesUseCaseProtocol.self, method:
    """
    fetchCategories() async
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_CategoriesUseCaseProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var dataStream: Cuckoo.VerifyReadOnlyProperty<PassthroughSubject<[CategoryModel], Never>> {
            return .init(manager: cuckoo_manager, name: "dataStream", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var errorStream: Cuckoo.VerifyReadOnlyProperty<PassthroughSubject<Error, Never>> {
            return .init(manager: cuckoo_manager, name: "errorStream", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func fetchCategories() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    fetchCategories() async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class CategoriesUseCaseProtocolStub: CategoriesUseCaseProtocol {
    
    
    
    
     var dataStream: PassthroughSubject<[CategoryModel], Never> {
        get {
            return DefaultValueRegistry.defaultValue(for: (PassthroughSubject<[CategoryModel], Never>).self)
        }
        
    }
    
    
    
    
    
     var errorStream: PassthroughSubject<Error, Never> {
        get {
            return DefaultValueRegistry.defaultValue(for: (PassthroughSubject<Error, Never>).self)
        }
        
    }
    
    

    

    
    
    
    
     func fetchCategories() async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: Meals/Presentation/UseCases/FoodItemsUseCase.swift at 2024-02-25 20:08:52 +0000

//
//  FoodItemsUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import Cuckoo
@testable import Meals

import Combine
import Foundation






 class MockFoodItemsUseCaseProtocol: FoodItemsUseCaseProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = FoodItemsUseCaseProtocol
    
     typealias Stubbing = __StubbingProxy_FoodItemsUseCaseProtocol
     typealias Verification = __VerificationProxy_FoodItemsUseCaseProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FoodItemsUseCaseProtocol?

     func enableDefaultImplementation(_ stub: FoodItemsUseCaseProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
     var dataStream: PassthroughSubject<[FoodItemModel], Never> {
        get {
            return cuckoo_manager.getter("dataStream",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.dataStream)
        }
        
    }
    
    
    
    
    
     var errorStream: PassthroughSubject<Error, Never> {
        get {
            return cuckoo_manager.getter("errorStream",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.errorStream)
        }
        
    }
    
    

    

    
    
    
    
     func fetchFoodItems(by categoryName: String) async {
        
    return await cuckoo_manager.call(
    """
    fetchFoodItems(by: String) async
    """,
            parameters: (categoryName),
            escapingParameters: (categoryName),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: await __defaultImplStub!.fetchFoodItems(by: categoryName))
        
    }
    
    

     struct __StubbingProxy_FoodItemsUseCaseProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var dataStream: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFoodItemsUseCaseProtocol, PassthroughSubject<[FoodItemModel], Never>> {
            return .init(manager: cuckoo_manager, name: "dataStream")
        }
        
        
        
        
        var errorStream: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFoodItemsUseCaseProtocol, PassthroughSubject<Error, Never>> {
            return .init(manager: cuckoo_manager, name: "errorStream")
        }
        
        
        
        
        
        func fetchFoodItems<M1: Cuckoo.Matchable>(by categoryName: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: categoryName) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFoodItemsUseCaseProtocol.self, method:
    """
    fetchFoodItems(by: String) async
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_FoodItemsUseCaseProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var dataStream: Cuckoo.VerifyReadOnlyProperty<PassthroughSubject<[FoodItemModel], Never>> {
            return .init(manager: cuckoo_manager, name: "dataStream", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        
        
        var errorStream: Cuckoo.VerifyReadOnlyProperty<PassthroughSubject<Error, Never>> {
            return .init(manager: cuckoo_manager, name: "errorStream", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func fetchFoodItems<M1: Cuckoo.Matchable>(by categoryName: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: categoryName) { $0 }]
            return cuckoo_manager.verify(
    """
    fetchFoodItems(by: String) async
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class FoodItemsUseCaseProtocolStub: FoodItemsUseCaseProtocol {
    
    
    
    
     var dataStream: PassthroughSubject<[FoodItemModel], Never> {
        get {
            return DefaultValueRegistry.defaultValue(for: (PassthroughSubject<[FoodItemModel], Never>).self)
        }
        
    }
    
    
    
    
    
     var errorStream: PassthroughSubject<Error, Never> {
        get {
            return DefaultValueRegistry.defaultValue(for: (PassthroughSubject<Error, Never>).self)
        }
        
    }
    
    

    

    
    
    
    
     func fetchFoodItems(by categoryName: String) async  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: Meals/Presentation/ViewModelFactory/CategoryViewModelFactory.swift at 2024-02-25 20:08:52 +0000

//
//  CategoryViewModelFactory.swift
//  Meals
//
//  Created by Dipen Panchasara on 20/02/2024.
//

import Cuckoo
@testable import Meals

import Foundation






 class MockCategoryViewModelFactoryProtocol: CategoryViewModelFactoryProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = CategoryViewModelFactoryProtocol
    
     typealias Stubbing = __StubbingProxy_CategoryViewModelFactoryProtocol
     typealias Verification = __VerificationProxy_CategoryViewModelFactoryProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CategoryViewModelFactoryProtocol?

     func enableDefaultImplementation(_ stub: CategoryViewModelFactoryProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func categoryListViewModel() -> CategoriesViewModel {
        
    return cuckoo_manager.call(
    """
    categoryListViewModel() -> CategoriesViewModel
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.categoryListViewModel())
        
    }
    
    
    
    
    
     func foodItemsViewModel(categoryName: String) -> FoodItemsViewModel {
        
    return cuckoo_manager.call(
    """
    foodItemsViewModel(categoryName: String) -> FoodItemsViewModel
    """,
            parameters: (categoryName),
            escapingParameters: (categoryName),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.foodItemsViewModel(categoryName: categoryName))
        
    }
    
    

     struct __StubbingProxy_CategoryViewModelFactoryProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func categoryListViewModel() -> Cuckoo.ProtocolStubFunction<(), CategoriesViewModel> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCategoryViewModelFactoryProtocol.self, method:
    """
    categoryListViewModel() -> CategoriesViewModel
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func foodItemsViewModel<M1: Cuckoo.Matchable>(categoryName: M1) -> Cuckoo.ProtocolStubFunction<(String), FoodItemsViewModel> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: categoryName) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCategoryViewModelFactoryProtocol.self, method:
    """
    foodItemsViewModel(categoryName: String) -> FoodItemsViewModel
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_CategoryViewModelFactoryProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func categoryListViewModel() -> Cuckoo.__DoNotUse<(), CategoriesViewModel> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    categoryListViewModel() -> CategoriesViewModel
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func foodItemsViewModel<M1: Cuckoo.Matchable>(categoryName: M1) -> Cuckoo.__DoNotUse<(String), FoodItemsViewModel> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: categoryName) { $0 }]
            return cuckoo_manager.verify(
    """
    foodItemsViewModel(categoryName: String) -> FoodItemsViewModel
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class CategoryViewModelFactoryProtocolStub: CategoryViewModelFactoryProtocol {
    

    

    
    
    
    
     func categoryListViewModel() -> CategoriesViewModel  {
        return DefaultValueRegistry.defaultValue(for: (CategoriesViewModel).self)
    }
    
    
    
    
    
     func foodItemsViewModel(categoryName: String) -> FoodItemsViewModel  {
        return DefaultValueRegistry.defaultValue(for: (FoodItemsViewModel).self)
    }
    
    
}










 class MockCategoryViewModelFactory: CategoryViewModelFactory, Cuckoo.ClassMock {
    
     typealias MocksType = CategoryViewModelFactory
    
     typealias Stubbing = __StubbingProxy_CategoryViewModelFactory
     typealias Verification = __VerificationProxy_CategoryViewModelFactory

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: CategoryViewModelFactory?

     func enableDefaultImplementation(_ stub: CategoryViewModelFactory) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     override func categoryListViewModel() -> CategoriesViewModel {
        
    return cuckoo_manager.call(
    """
    categoryListViewModel() -> CategoriesViewModel
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.categoryListViewModel()
                ,
            defaultCall: __defaultImplStub!.categoryListViewModel())
        
    }
    
    
    
    
    
     override func foodItemsViewModel(categoryName: String) -> FoodItemsViewModel {
        
    return cuckoo_manager.call(
    """
    foodItemsViewModel(categoryName: String) -> FoodItemsViewModel
    """,
            parameters: (categoryName),
            escapingParameters: (categoryName),
            superclassCall:
                
                super.foodItemsViewModel(categoryName: categoryName)
                ,
            defaultCall: __defaultImplStub!.foodItemsViewModel(categoryName: categoryName))
        
    }
    
    

     struct __StubbingProxy_CategoryViewModelFactory: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func categoryListViewModel() -> Cuckoo.ClassStubFunction<(), CategoriesViewModel> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCategoryViewModelFactory.self, method:
    """
    categoryListViewModel() -> CategoriesViewModel
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func foodItemsViewModel<M1: Cuckoo.Matchable>(categoryName: M1) -> Cuckoo.ClassStubFunction<(String), FoodItemsViewModel> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: categoryName) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockCategoryViewModelFactory.self, method:
    """
    foodItemsViewModel(categoryName: String) -> FoodItemsViewModel
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_CategoryViewModelFactory: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func categoryListViewModel() -> Cuckoo.__DoNotUse<(), CategoriesViewModel> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    categoryListViewModel() -> CategoriesViewModel
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func foodItemsViewModel<M1: Cuckoo.Matchable>(categoryName: M1) -> Cuckoo.__DoNotUse<(String), FoodItemsViewModel> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: categoryName) { $0 }]
            return cuckoo_manager.verify(
    """
    foodItemsViewModel(categoryName: String) -> FoodItemsViewModel
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class CategoryViewModelFactoryStub: CategoryViewModelFactory {
    

    

    
    
    
    
     override func categoryListViewModel() -> CategoriesViewModel  {
        return DefaultValueRegistry.defaultValue(for: (CategoriesViewModel).self)
    }
    
    
    
    
    
     override func foodItemsViewModel(categoryName: String) -> FoodItemsViewModel  {
        return DefaultValueRegistry.defaultValue(for: (FoodItemsViewModel).self)
    }
    
    
}




