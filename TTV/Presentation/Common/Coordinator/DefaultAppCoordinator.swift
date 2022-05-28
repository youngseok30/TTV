//
//  DefaultAppCoordinator.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import UIKit

final class DefaultAppCoordinator: AppCoordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType = .app
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        let coordinator = DefaultSplashCoordinator(self.navigationController)
        coordinator.finishDelegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
}

extension DefaultAppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter({ $0.type != childCoordinator.type })
        self.navigationController.viewControllers.removeAll()
    }
}
