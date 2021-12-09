//
//  HomeViewModel.swift
//  SceneCoordinator
//
//  Created by Damor on 2021/12/09.
//

import Foundation

protocol HomeListener: AnyObject {
    func didTapNext()
}

protocol HomeDependency: Dependency {
    
}

final class HomeViewModel {
    private let dependency: HomeDependency
    private weak var listener: HomeListener?
    
    init(dependency: HomeDependency, listener: HomeListener?) {
        self.dependency = dependency
        self.listener = listener
    }
    
    func didTapNext() {
        listener?.didTapNext()
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
}


protocol Dependency: AnyObject {}
