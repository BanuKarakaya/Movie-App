//
//  DetailViewModel.swift
//  Movie App
//
//  Created by Latif Atci on 8.09.2025.
//

import Foundation

protocol DetailViewModelProtocol {
    func viewDidLoad()
}

protocol DetailViewModelDelegate: AnyObject {
    func configure(selectedMovie: Search?)
    func prepareBannerImage(with urlString: String?)
    func prepareUI()
}

final class DetailViewModel {
    private weak var delegate: DetailViewModelDelegate?
    var selectedMovie: Search?
    
    init(delegate: DetailViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.configure(selectedMovie: selectedMovie!)
    }
}
