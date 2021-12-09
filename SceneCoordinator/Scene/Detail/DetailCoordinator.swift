//
//  DetailCoordinator.swift
//  SceneCoordinator
//
//  Created by Damor on 2021/12/09.
//

import UIKit

final class DetailCoordinator: Coordinator {
    
    private let dependency: DetailDependency
    private let navigationController: UINavigationController
    private weak var parent: DetailCoordinatorListener?
    var childCoordinators: [Coordinator] = []
    
    init(dependency: DetailDependency, navigationContrller: UINavigationController, parent: DetailCoordinatorListener) {
        self.dependency = dependency
        self.navigationController = navigationContrller
        self.parent = parent
    }
    
    func start() {
        let viewModel = DetailViewModel(dependency: dependency, listener: self)
        let viewController = DetailViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
}

extension DetailCoordinator: DetailListener {
    func didTapBack() {
        parent?.detachDetail()
    }
}

protocol DetailCoordinatorListener where Self: Coordinator {
    func detachDetail()
}
