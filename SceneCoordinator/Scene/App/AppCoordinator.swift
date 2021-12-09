//
//  AppCoordinator.swift
//  SceneCoordinator
//
//  Created by Damor on 2021/12/09.
//

import Foundation
import UIKit
import Combine

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        attachHome()
    }
    
    func attachHome() {
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let homeCoordinator = HomeCoordinator(dependency: AppComponent(), navigationController: navigationController)
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
    }
}

final class AppComponent: HomeDependency {
    var receivedMessage = CurrentValueSubject<String, Never>("Next")
}
