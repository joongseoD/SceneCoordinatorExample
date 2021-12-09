//
//  HomeCoordinator.swift
//  SceneCoordinator
//
//  Created by Damor on 2021/12/09.
//

import Foundation
import UIKit

final class HomeCoordinator: Coordinator {
    private let dependency: HomeDependency
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(dependency: HomeDependency, navigationController: UINavigationController) {
        self.dependency = dependency
        self.navigationController = navigationController
    }
 
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    func start() {
        let viewModel = HomeViewModel(dependency: dependency,
                                      listener: self)
        let homeViewController = HomeViewController(viewModel: viewModel)
        navigationController.viewControllers = [homeViewController]
    }
    
    private func attachDetail() {
        let component = HomeComponent()
        let coordinator = DetailCoordinator(dependency: component,
                                            navigationContrller: navigationController,
                                            parent: self)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    func detachDetail() {
        guard let detailCoordinatorIndex = findChild(type: DetailCoordinator.self) else { return }
        navigationController.popViewController(animated: true)
        childCoordinators.remove(at: detailCoordinatorIndex)
    }
}

final class HomeComponent: DetailDependency {
    
}

extension HomeCoordinator: HomeListener, DetailCoordinatorListener {
    func didTapNext() {
        attachDetail()
    }
}
