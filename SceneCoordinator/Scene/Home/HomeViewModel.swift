//
//  HomeViewModel.swift
//  SceneCoordinator
//
//  Created by Damor on 2021/12/09.
//

import Foundation
import Combine

protocol HomeListener: AnyObject {
    func didTapNext(tapCount: Int)
}

protocol HomeDependency: Dependency {
    var receivedMessage: CurrentValueSubject<String, Never> { get set }
}

final class HomeViewModel {
    private let dependency: HomeDependency
    private weak var listener: HomeListener?
    private var tapCount: Int = 0
    
    let buttonTitle: AnyPublisher<String, Never>
    
    init(dependency: HomeDependency, listener: HomeListener?) {
        self.dependency = dependency
        self.listener = listener
        
        self.buttonTitle = dependency.receivedMessage.eraseToAnyPublisher()
    }
    
    func didTapNext() {
        tapCount += 1
        listener?.didTapNext(tapCount: tapCount)
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
}


protocol Dependency: AnyObject {}
