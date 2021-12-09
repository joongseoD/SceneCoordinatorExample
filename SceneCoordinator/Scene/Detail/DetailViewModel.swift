//
//  DetailViewModel.swift
//  SceneCoordinator
//
//  Created by Damor on 2021/12/09.
//

import Foundation

protocol DetailDependency: AnyObject {
    
}

protocol DetailListener: AnyObject {
    func didTapBack()
}

final class DetailViewModel {
    private let dependency: DetailDependency
    private weak var listener: DetailListener?
    
    init(dependency: DetailDependency, listener: DetailListener?) {
        self.dependency = dependency
        self.listener = listener
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    func didTapBack() {
        listener?.didTapBack()
    }
}
