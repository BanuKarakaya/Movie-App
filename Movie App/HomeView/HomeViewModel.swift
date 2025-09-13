//
//  HomeViewModel.swift
//  Movie App
//
//  Created by Banu on 1.09.2025.
//

import Foundation

protocol HomeViewModelProtocol {
    func viewDidLoad()
}

protocol HomeViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func setUI()
}

final class HomeViewModel {
    private weak var delegate: HomeViewModelDelegate?
    
    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.setUI()
    }
}
