//
//  DetailViewModel.swift
//  SceneCoordinator
//
//  Created by Damor on 2021/12/09.
//

import Foundation
import Combine

protocol DetailDependency: AnyObject {
    var number: CurrentValueSubject<Int, Never> { get }
}

protocol DetailListener: AnyObject {
    func didTapBack(with message: String)
}

final class DetailViewModel {
    private let dependency: DetailDependency
    private weak var listener: DetailListener?
    
    private let tapCount: CurrentValueSubject<Int, Never>
    var number: AnyPublisher<Int, Never> { tapCount.eraseToAnyPublisher() }
    
    init(dependency: DetailDependency, listener: DetailListener?) {
        self.dependency = dependency
        self.listener = listener
        self.tapCount = dependency.number
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    func didTapBack() {
        listener?.didTapBack(with: "Next (count: \(tapCount.value))")
    }
}
