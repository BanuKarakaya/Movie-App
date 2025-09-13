//
//  MovieCellViewModel.swift
//  Movie App
//
//  Created by Latif Atci on 8.09.2025.
//

import Foundation

protocol MovieCellViewModelProtocol {
    func viewDidLoad()
}

protocol MovieCellViewModelDelegate: AnyObject {
    func setUI()
}

final class MovieCellViewModel {
    private weak var delegate: MovieCellViewModelDelegate?
    
    init(delegate: MovieCellViewModelDelegate) {
        self.delegate = delegate
    }
}

extension MovieCellViewModel: MovieCellViewModelProtocol {
    
    func viewDidLoad() {
        delegate?.setUI()
    }
}
