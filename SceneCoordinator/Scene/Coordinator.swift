//
//  Coordinator.swift
//  SceneCoordinator
//
//  Created by Damor on 2021/12/09.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    func findChild<T: Coordinator>(type: T.Type) -> Int? {
        childCoordinators.firstIndex(where: { $0 is T })
    }
}
