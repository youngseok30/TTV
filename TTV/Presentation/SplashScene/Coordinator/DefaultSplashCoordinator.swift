//
//  DefaultSplashCoordinator.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit

final class DefaultSplashCoordinator: SplashCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType = .splash
    var splashViewController: SplashViewController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.splashViewController = SplashViewController()
    }
    
    func start() {
        self.splashViewController.viewModel = SplashViewModel(coordinator: self)
        self.navigationController.pushViewController(self.splashViewController, animated: true)
    }
    
    func finish() {
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func showIntroduce() {
        let coordinator = DefaultIntroduceCoordinator(self.navigationController)
        coordinator.finishDelegate = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
}

extension DefaultSplashCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
