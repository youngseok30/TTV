//
//  DefaultIntroduceCoordinator.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit

final class DefaultIntroduceCoordinator: IntroduceCoordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType = .introduce
    var introduceViewController: IntroduceViewController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.introduceViewController = IntroduceViewController()
    }
    
    func start() {
        self.introduceViewController.viewModel = IntroduceViewModel(coordinator: self)
        self.navigationController.pushViewController(self.introduceViewController, animated: true)
    }
    
    func finish() {
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func showAuth() {
        
    }
    
}

extension DefaultIntroduceCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
