//
//  DefaultLoginCoordinator.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation
import UIKit

final class DefaultLoginCoordinator: LoginCoordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType = .login
    var loginViewController: LoginViewController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.loginViewController = LoginViewController()
    }
    
    func start() {
        self.loginViewController.viewModel = LoginViewModel(coordinator: self, useCase: DefaultLoginUseCase())
        self.navigationController.pushViewController(self.loginViewController, animated: true)
    }
    
    func finish() {
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func showMain() {
    }
    
    func signUp() {
    }
    
}

extension DefaultLoginCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
