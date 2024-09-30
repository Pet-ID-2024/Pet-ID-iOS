//
//  DIConatiner.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 6/30/24.
//

import Foundation
import Swinject

// 의존성 주입을 위한 DIContainer 클래스
final class DIContainer {
    
    // 싱글톤 인스턴스
    static let shared = DIContainer()
    
    // Swinject 컨테이너 인스턴스
    private let container: Container
    
    private init() {
        self.container = Container() // Swinject 컨테이너 초기화
    }
    
    // 주입할 서비스를 해제해 반환하는 메서드
    // - Parameter serviceType: 서비스의 타입
    // - Returns: 주입된 서비스
    func resolve<T>(_ serviceType: T.Type) -> T {
        return container.resolve(serviceType)! // 해당 타입의 서비스를 반환
    }
    
    // 서비스 등록 메서드
    // - Interface: 서비스의 타입
    // - implement: 서비스를 생성하는 팩토리 클로저
    func register<T>(interface: T.Type, implement: @escaping ((Resolver) -> T)) {
        container.register(interface, factory: implement) // 인터페이스와 구현체를 컨테이너에 등록
    }
}
