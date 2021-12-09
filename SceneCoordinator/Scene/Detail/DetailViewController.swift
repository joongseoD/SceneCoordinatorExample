//
//  DetailViewController.swift
//  SceneCoordinator
//
//  Created by Damor on 2021/12/09.
//

import UIKit
import Combine

final class DetailViewController: UIViewController {
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()

    private let viewModel: DetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
    }
    
    private func setupViews() {
        view.backgroundColor = .red
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward",
                                                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapBack))
        
        view.addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            numberLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func bindViewModel() {
        viewModel.number
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.numberLabel.text = "\(value)"
            }
            .store(in: &cancellables)
    }
    
    @objc private func didTapBack() {
        viewModel.didTapBack()
    }
}
