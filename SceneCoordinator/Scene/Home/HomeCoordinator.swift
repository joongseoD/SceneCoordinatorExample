//
//  HomeCoordinator.swift
//  SceneCoordinator
//
//  Created by Damor on 2021/12/09.
//

import UIKit
import Combine

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
        let viewModel = HomeViewModel(dependency: dependency, listener: self)
        let homeViewController = HomeViewController(viewModel: viewModel)
        navigationController.viewControllers = [homeViewController]
    }
    
    private func attachDetail(tapCount: Int) {
        let tapCountPublisher = CurrentValueSubject<Int, Never>(tapCount)
        let component = HomeComponent(number: tapCountPublisher)
        let coordinator = DetailCoordinator(dependency: component, navigationContrller: navigationController, parent: self)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

final class HomeComponent: DetailDependency {
    var number: CurrentValueSubject<Int, Never>
    
    init(number: CurrentValueSubject<Int, Never>) {
        self.number = number
    }
}

extension HomeCoordinator: HomeListener, DetailCoordinatorListener {
    func didTapNext(tapCount: Int) {
        attachDetail(tapCount: tapCount)
    }
    
    func deliverMessage(_ message: String) {
        dependency.receivedMessage.send(message)
    }
    
    func detachDetail() {
        guard let detailCoordinatorIndex = findChild(type: DetailCoordinator.self) else { return }
        navigationController.popViewController(animated: true)
        childCoordinators.remove(at: detailCoordinatorIndex)
    }
}
