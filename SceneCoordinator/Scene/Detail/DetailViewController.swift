//
//  DetailViewController.swift
//  SceneCoordinator
//
//  Created by Damor on 2021/12/09.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel
    
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
    }
    
    private func setupViews() {
        view.backgroundColor = .red
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward",
                                                                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapBack))
    }
    
    @objc private func didTapBack() {
        viewModel.didTapBack()
    }
}
