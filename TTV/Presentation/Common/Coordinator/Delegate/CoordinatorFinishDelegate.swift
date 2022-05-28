//
//  CoordinatorFinishDelegate.swift
//  TTV
//
//  Created by Ethan Lee on 2022/05/28.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {
    
    func coordinatorDidFinish(childCoordinator: Coordinator)
    
}
