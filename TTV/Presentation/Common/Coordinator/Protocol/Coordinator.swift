//
//  Coordinator.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }
    
    func start()
    func finish()
    func findCoordinator(type: CoordinatorType) -> Coordinator?
    
    init(_ navigationController: UINavigationController)
    
}


extension Coordinator {
    
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func findCoordinator(type: CoordinatorType) -> Coordinator? {
        var stack: [Coordinator] = [self]
        
        while !stack.isEmpty {
            let currentCoordinator = stack.removeLast()
            if currentCoordinator.type == type {
                return currentCoordinator
            }
            
            currentCoordinator.childCoordinators.forEach { stack.append($0) }
        }
        
        return nil
    }
}
