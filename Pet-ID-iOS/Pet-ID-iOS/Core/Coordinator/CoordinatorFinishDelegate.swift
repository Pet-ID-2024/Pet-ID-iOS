//
//  CoordinatorFinishDelegate.swift
//  Pet-ID-iOS
//
//  Created by 강현준 on 7/23/24.
//

import Foundation

public protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: any Coordinator)
}
