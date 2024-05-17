// MARK: - Mocks generated from file: Meals/Navigation/CategoryRouter.swift at 2024-05-16 20:52:32 +0000

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
    

    
    
    
    
     var router: RouterProtocol {
        get {
            return cuckoo_manager.getter("router",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.router)
        }
        
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
        
        
        
        var router: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCategoryRouterProtocol, RouterProtocol> {
            return .init(manager: cuckoo_manager, name: "router")
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
    
        
        
        
        var router: Cuckoo.VerifyReadOnlyProperty<RouterProtocol> {
            return .init(manager: cuckoo_manager, name: "router", callMatcher: callMatcher, sourceLocation: sourceLocation)
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
    
    
    
    
     var router: RouterProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (RouterProtocol).self)
        }
        
    }
    
    

    

    
    
    
    
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





// MARK: - Mocks generated from file: Meals/Navigation/Router.swift at 2024-05-16 20:52:32 +0000

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
    

    

    

    
    
    
    
     func push(destination: any Hashable)  {
        
    return cuckoo_manager.call(
    """
    push(destination: any Hashable)
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
    
    

     struct __StubbingProxy_RouterProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func push<M1: Cuckoo.Matchable>(destination: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(any Hashable)> where M1.MatchedType == any Hashable {
            let matchers: [Cuckoo.ParameterMatcher<(any Hashable)>] = [wrap(matchable: destination) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRouterProtocol.self, method:
    """
    push(destination: any Hashable)
    """, parameterMatchers: matchers))
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
        func push<M1: Cuckoo.Matchable>(destination: M1) -> Cuckoo.__DoNotUse<(any Hashable), Void> where M1.MatchedType == any Hashable {
            let matchers: [Cuckoo.ParameterMatcher<(any Hashable)>] = [wrap(matchable: destination) { $0 }]
            return cuckoo_manager.verify(
    """
    push(destination: any Hashable)
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


 class RouterProtocolStub: RouterProtocol {
    

    

    
    
    
    
     func push(destination: any Hashable)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func pop()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func popToRootView()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}










 class MockModuleRouter: ModuleRouter, Cuckoo.ProtocolMock {
    
     typealias MocksType = ModuleRouter
    
     typealias Stubbing = __StubbingProxy_ModuleRouter
     typealias Verification = __VerificationProxy_ModuleRouter

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ModuleRouter?

     func enableDefaultImplementation(_ stub: ModuleRouter) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
     var router: RouterProtocol {
        get {
            return cuckoo_manager.getter("router",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.router)
        }
        
    }
    
    

    

    

     struct __StubbingProxy_ModuleRouter: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var router: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockModuleRouter, RouterProtocol> {
            return .init(manager: cuckoo_manager, name: "router")
        }
        
        
        
    }

     struct __VerificationProxy_ModuleRouter: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var router: Cuckoo.VerifyReadOnlyProperty<RouterProtocol> {
            return .init(manager: cuckoo_manager, name: "router", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
    }
}


 class ModuleRouterStub: ModuleRouter {
    
    
    
    
     var router: RouterProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (RouterProtocol).self)
        }
        
    }
    
    

    

    
}





// MARK: - Mocks generated from file: Meals/NetworkManager/NetworkManager.swift at 2024-05-16 20:52:32 +0000

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
    

    

    

    
    
    
    
     func execute<T>(networkRequest: NetworkRequest) -> AnyPublisher<T, Error> where T: Decodable {
        
    return cuckoo_manager.call(
    """
    execute(networkRequest: NetworkRequest) -> AnyPublisher<T, Error> where T: Decodable
    """,
            parameters: (networkRequest),
            escapingParameters: (networkRequest),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute(networkRequest: networkRequest))
        
    }
    
    
    
    
    
     func executeWithCache(networkRequest: NetworkRequest) -> AnyPublisher<NetworkResponse, Error> {
        
    return cuckoo_manager.call(
    """
    executeWithCache(networkRequest: NetworkRequest) -> AnyPublisher<NetworkResponse, Error>
    """,
            parameters: (networkRequest),
            escapingParameters: (networkRequest),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.executeWithCache(networkRequest: networkRequest))
        
    }
    
    

     struct __StubbingProxy_NetworkProvider: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func execute<M1: Cuckoo.Matchable, T>(networkRequest: M1) -> Cuckoo.ProtocolStubFunction<(NetworkRequest), AnyPublisher<T, Error>> where M1.MatchedType == NetworkRequest, T: Decodable {
            let matchers: [Cuckoo.ParameterMatcher<(NetworkRequest)>] = [wrap(matchable: networkRequest) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNetworkProvider.self, method:
    """
    execute(networkRequest: NetworkRequest) -> AnyPublisher<T, Error> where T: Decodable
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func executeWithCache<M1: Cuckoo.Matchable>(networkRequest: M1) -> Cuckoo.ProtocolStubFunction<(NetworkRequest), AnyPublisher<NetworkResponse, Error>> where M1.MatchedType == NetworkRequest {
            let matchers: [Cuckoo.ParameterMatcher<(NetworkRequest)>] = [wrap(matchable: networkRequest) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNetworkProvider.self, method:
    """
    executeWithCache(networkRequest: NetworkRequest) -> AnyPublisher<NetworkResponse, Error>
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
        func execute<M1: Cuckoo.Matchable, T>(networkRequest: M1) -> Cuckoo.__DoNotUse<(NetworkRequest), AnyPublisher<T, Error>> where M1.MatchedType == NetworkRequest, T: Decodable {
            let matchers: [Cuckoo.ParameterMatcher<(NetworkRequest)>] = [wrap(matchable: networkRequest) { $0 }]
            return cuckoo_manager.verify(
    """
    execute(networkRequest: NetworkRequest) -> AnyPublisher<T, Error> where T: Decodable
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func executeWithCache<M1: Cuckoo.Matchable>(networkRequest: M1) -> Cuckoo.__DoNotUse<(NetworkRequest), AnyPublisher<NetworkResponse, Error>> where M1.MatchedType == NetworkRequest {
            let matchers: [Cuckoo.ParameterMatcher<(NetworkRequest)>] = [wrap(matchable: networkRequest) { $0 }]
            return cuckoo_manager.verify(
    """
    executeWithCache(networkRequest: NetworkRequest) -> AnyPublisher<NetworkResponse, Error>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class NetworkProviderStub: NetworkProvider {
    

    

    
    
    
    
     func execute<T>(networkRequest: NetworkRequest) -> AnyPublisher<T, Error> where T: Decodable  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<T, Error>).self)
    }
    
    
    
    
    
     func executeWithCache(networkRequest: NetworkRequest) -> AnyPublisher<NetworkResponse, Error>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<NetworkResponse, Error>).self)
    }
    
    
}










 class MockNetworkCacheProvider: NetworkCacheProvider, Cuckoo.ProtocolMock {
    
     typealias MocksType = NetworkCacheProvider
    
     typealias Stubbing = __StubbingProxy_NetworkCacheProvider
     typealias Verification = __VerificationProxy_NetworkCacheProvider

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: NetworkCacheProvider?

     func enableDefaultImplementation(_ stub: NetworkCacheProvider) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func cached(urlRequest: URLRequest) -> AnyPublisher<NetworkResponse, Error> {
        
    return cuckoo_manager.call(
    """
    cached(urlRequest: URLRequest) -> AnyPublisher<NetworkResponse, Error>
    """,
            parameters: (urlRequest),
            escapingParameters: (urlRequest),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.cached(urlRequest: urlRequest))
        
    }
    
    

     struct __StubbingProxy_NetworkCacheProvider: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func cached<M1: Cuckoo.Matchable>(urlRequest: M1) -> Cuckoo.ProtocolStubFunction<(URLRequest), AnyPublisher<NetworkResponse, Error>> where M1.MatchedType == URLRequest {
            let matchers: [Cuckoo.ParameterMatcher<(URLRequest)>] = [wrap(matchable: urlRequest) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNetworkCacheProvider.self, method:
    """
    cached(urlRequest: URLRequest) -> AnyPublisher<NetworkResponse, Error>
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_NetworkCacheProvider: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func cached<M1: Cuckoo.Matchable>(urlRequest: M1) -> Cuckoo.__DoNotUse<(URLRequest), AnyPublisher<NetworkResponse, Error>> where M1.MatchedType == URLRequest {
            let matchers: [Cuckoo.ParameterMatcher<(URLRequest)>] = [wrap(matchable: urlRequest) { $0 }]
            return cuckoo_manager.verify(
    """
    cached(urlRequest: URLRequest) -> AnyPublisher<NetworkResponse, Error>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class NetworkCacheProviderStub: NetworkCacheProvider {
    

    

    
    
    
    
     func cached(urlRequest: URLRequest) -> AnyPublisher<NetworkResponse, Error>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<NetworkResponse, Error>).self)
    }
    
    
}





// MARK: - Mocks generated from file: Meals/NetworkManager/NetworkSessionProvider.swift at 2024-05-16 20:52:32 +0000

//
//  NetworkSessionProvider.swift
//  Meals
//
//  Created by Dipen Panchasara on 06/02/2024.
//

import Cuckoo
@testable import Meals

import Combine
import Foundation






 class MockNetworkSessionProvider: NetworkSessionProvider, Cuckoo.ProtocolMock {
    
     typealias MocksType = NetworkSessionProvider
    
     typealias Stubbing = __StubbingProxy_NetworkSessionProvider
     typealias Verification = __VerificationProxy_NetworkSessionProvider

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: NetworkSessionProvider?

     func enableDefaultImplementation(_ stub: NetworkSessionProvider) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    
     var session: URLSession {
        get {
            return cuckoo_manager.getter("session",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.session)
        }
        
    }
    
    

    

    
    
    
    
     func dataTaskPublisher(for urlRequest: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), any Error> {
        
    return cuckoo_manager.call(
    """
    dataTaskPublisher(for: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), any Error>
    """,
            parameters: (urlRequest),
            escapingParameters: (urlRequest),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.dataTaskPublisher(for: urlRequest))
        
    }
    
    

     struct __StubbingProxy_NetworkSessionProvider: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var session: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockNetworkSessionProvider, URLSession> {
            return .init(manager: cuckoo_manager, name: "session")
        }
        
        
        
        
        
        func dataTaskPublisher<M1: Cuckoo.Matchable>(for urlRequest: M1) -> Cuckoo.ProtocolStubFunction<(URLRequest), AnyPublisher<(data: Data, response: URLResponse), any Error>> where M1.MatchedType == URLRequest {
            let matchers: [Cuckoo.ParameterMatcher<(URLRequest)>] = [wrap(matchable: urlRequest) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNetworkSessionProvider.self, method:
    """
    dataTaskPublisher(for: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), any Error>
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_NetworkSessionProvider: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
        
        
        var session: Cuckoo.VerifyReadOnlyProperty<URLSession> {
            return .init(manager: cuckoo_manager, name: "session", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func dataTaskPublisher<M1: Cuckoo.Matchable>(for urlRequest: M1) -> Cuckoo.__DoNotUse<(URLRequest), AnyPublisher<(data: Data, response: URLResponse), any Error>> where M1.MatchedType == URLRequest {
            let matchers: [Cuckoo.ParameterMatcher<(URLRequest)>] = [wrap(matchable: urlRequest) { $0 }]
            return cuckoo_manager.verify(
    """
    dataTaskPublisher(for: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), any Error>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class NetworkSessionProviderStub: NetworkSessionProvider {
    
    
    
    
     var session: URLSession {
        get {
            return DefaultValueRegistry.defaultValue(for: (URLSession).self)
        }
        
    }
    
    

    

    
    
    
    
     func dataTaskPublisher(for urlRequest: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), any Error>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<(data: Data, response: URLResponse), any Error>).self)
    }
    
    
}





// MARK: - Mocks generated from file: Meals/NetworkManager/ResponseDecoder.swift at 2024-05-16 20:52:32 +0000

//
//  ResponseDecoder.swift
//  Meals
//
//  Created by Dipen Panchasara on 04/02/2024.
//

import Cuckoo
@testable import Meals

import Foundation






 class MockResponseDecoderProvider: ResponseDecoderProvider, Cuckoo.ProtocolMock {
    
     typealias MocksType = ResponseDecoderProvider
    
     typealias Stubbing = __StubbingProxy_ResponseDecoderProvider
     typealias Verification = __VerificationProxy_ResponseDecoderProvider

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ResponseDecoderProvider?

     func enableDefaultImplementation(_ stub: ResponseDecoderProvider) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    
     func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        
    return try cuckoo_manager.callThrows(
    """
    decode(_: T.Type, from: Data) throws -> T where T: Decodable
    """,
            parameters: (type, data),
            escapingParameters: (type, data),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.decode(type, from: data))
        
    }
    
    

     struct __StubbingProxy_ResponseDecoderProvider: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        
        func decode<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, T>(_ type: M1, from data: M2) -> Cuckoo.ProtocolStubThrowingFunction<(T.Type, Data), T> where M1.MatchedType == T.Type, M2.MatchedType == Data, T: Decodable {
            let matchers: [Cuckoo.ParameterMatcher<(T.Type, Data)>] = [wrap(matchable: type) { $0.0 }, wrap(matchable: data) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockResponseDecoderProvider.self, method:
    """
    decode(_: T.Type, from: Data) throws -> T where T: Decodable
    """, parameterMatchers: matchers))
        }
        
        
    }

     struct __VerificationProxy_ResponseDecoderProvider: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
         init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    
        
    
        
        
        
        @discardableResult
        func decode<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, T>(_ type: M1, from data: M2) -> Cuckoo.__DoNotUse<(T.Type, Data), T> where M1.MatchedType == T.Type, M2.MatchedType == Data, T: Decodable {
            let matchers: [Cuckoo.ParameterMatcher<(T.Type, Data)>] = [wrap(matchable: type) { $0.0 }, wrap(matchable: data) { $0.1 }]
            return cuckoo_manager.verify(
    """
    decode(_: T.Type, from: Data) throws -> T where T: Decodable
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class ResponseDecoderProviderStub: ResponseDecoderProvider {
    

    

    
    
    
    
     func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable  {
        return DefaultValueRegistry.defaultValue(for: (T).self)
    }
    
    
}





// MARK: - Mocks generated from file: Meals/Presentation/UseCases/CategoriesUseCase.swift at 2024-05-16 20:52:32 +0000

//
//  CategoriesUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 01/02/2024.
//

import Cuckoo
@testable import Meals

import Combine
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
    

    
    
    
    
     var publisher: AnyPublisher<Result<[CategoryModel], Error>, Never> {
        get {
            return cuckoo_manager.getter("publisher",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.publisher)
        }
        
    }
    
    

    

    
    
    
    
     func fetchCategories()  {
        
    return cuckoo_manager.call(
    """
    fetchCategories()
    """,
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.fetchCategories())
        
    }
    
    
    
    
    
     func fetchCategories() async -> Result<[CategoryModel], Error> {
        
    return await cuckoo_manager.call(
    """
    fetchCategories() async -> Result<[CategoryModel], Error>
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
        
        
        
        var publisher: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCategoriesUseCaseProtocol, AnyPublisher<Result<[CategoryModel], Error>, Never>> {
            return .init(manager: cuckoo_manager, name: "publisher")
        }
        
        
        
        
        
        func fetchCategories() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCategoriesUseCaseProtocol.self, method:
    """
    fetchCategories()
    """, parameterMatchers: matchers))
        }
        
        
        
        
        func fetchCategories() -> Cuckoo.ProtocolStubFunction<(), Result<[CategoryModel], Error>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockCategoriesUseCaseProtocol.self, method:
    """
    fetchCategories() async -> Result<[CategoryModel], Error>
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
    
        
        
        
        var publisher: Cuckoo.VerifyReadOnlyProperty<AnyPublisher<Result<[CategoryModel], Error>, Never>> {
            return .init(manager: cuckoo_manager, name: "publisher", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func fetchCategories() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    fetchCategories()
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
        
        
        @discardableResult
        func fetchCategories() -> Cuckoo.__DoNotUse<(), Result<[CategoryModel], Error>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
    """
    fetchCategories() async -> Result<[CategoryModel], Error>
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class CategoriesUseCaseProtocolStub: CategoriesUseCaseProtocol {
    
    
    
    
     var publisher: AnyPublisher<Result<[CategoryModel], Error>, Never> {
        get {
            return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<[CategoryModel], Error>, Never>).self)
        }
        
    }
    
    

    

    
    
    
    
     func fetchCategories()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
    
    
    
     func fetchCategories() async -> Result<[CategoryModel], Error>  {
        return DefaultValueRegistry.defaultValue(for: (Result<[CategoryModel], Error>).self)
    }
    
    
}





// MARK: - Mocks generated from file: Meals/Presentation/UseCases/FoodItemsUseCase.swift at 2024-05-16 20:52:32 +0000

//
//  FoodItemsUseCase.swift
//  Meals
//
//  Created by Dipen Panchasara on 19/02/2024.
//

import Cuckoo
@testable import Meals

import Combine
import SwiftUI






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
    

    
    
    
    
     var publisher: AnyPublisher<Result<[FoodItemModel], Error>, Never> {
        get {
            return cuckoo_manager.getter("publisher",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall:  __defaultImplStub!.publisher)
        }
        
    }
    
    

    

    
    
    
    
     func fetchFoodItems(by categoryName: String)  {
        
    return cuckoo_manager.call(
    """
    fetchFoodItems(by: String)
    """,
            parameters: (categoryName),
            escapingParameters: (categoryName),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.fetchFoodItems(by: categoryName))
        
    }
    
    

     struct __StubbingProxy_FoodItemsUseCaseProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
         init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        
        
        var publisher: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFoodItemsUseCaseProtocol, AnyPublisher<Result<[FoodItemModel], Error>, Never>> {
            return .init(manager: cuckoo_manager, name: "publisher")
        }
        
        
        
        
        
        func fetchFoodItems<M1: Cuckoo.Matchable>(by categoryName: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: categoryName) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockFoodItemsUseCaseProtocol.self, method:
    """
    fetchFoodItems(by: String)
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
    
        
        
        
        var publisher: Cuckoo.VerifyReadOnlyProperty<AnyPublisher<Result<[FoodItemModel], Error>, Never>> {
            return .init(manager: cuckoo_manager, name: "publisher", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
    
        
        
        
        @discardableResult
        func fetchFoodItems<M1: Cuckoo.Matchable>(by categoryName: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: categoryName) { $0 }]
            return cuckoo_manager.verify(
    """
    fetchFoodItems(by: String)
    """, callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
        }
        
        
    }
}


 class FoodItemsUseCaseProtocolStub: FoodItemsUseCaseProtocol {
    
    
    
    
     var publisher: AnyPublisher<Result<[FoodItemModel], Error>, Never> {
        get {
            return DefaultValueRegistry.defaultValue(for: (AnyPublisher<Result<[FoodItemModel], Error>, Never>).self)
        }
        
    }
    
    

    

    
    
    
    
     func fetchFoodItems(by categoryName: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    
}





// MARK: - Mocks generated from file: Meals/Presentation/ViewModelFactory/CategoryViewModelFactory.swift at 2024-05-16 20:52:32 +0000

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




