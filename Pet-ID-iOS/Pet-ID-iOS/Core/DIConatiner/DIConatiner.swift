//
//  DIConatiner.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation
import Swinject

final class DIContainer {
    
    static let shared = DIContainer()
    
    private let container: Container
    
    private init() {
        self.container = Container()
    }
    
    func resolve<T>(_ serviceType: T.Type) -> T {
        return container.resolve(serviceType)!
    }
    
    func register<T>(interface: T.Type, implement: @escaping ((Resolver) -> T)) {
        container.register(interface, factory: implement)
    }
}
