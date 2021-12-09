//
//  HomeViewController.swift
//  SceneCoordinator
//
//  Created by Damor on 2021/12/09.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        return button
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
    }
    
    private func setupViews() {
        view.backgroundColor = .blue
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func bindViewModel() {
        viewModel.buttonTitle
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.nextButton.setTitle(value, for: .normal)
            }
            .store(in: &cancellables)
    }
    
    @objc private func didTapNext() {
        viewModel.didTapNext()
    }
}
