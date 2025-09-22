//
//  MovieCellViewModel.swift
//  Movie App
//
//  Created by Latif Atci on 8.09.2025.
//

import Foundation

protocol MovieCellViewModelProtocol {
    func viewDidLoad()
    func load()
}

protocol MovieCellViewModelDelegate: AnyObject {
    func setUI()
    func configureCell(movie: Search?)
    func prepareBannerImage(with urlString: String?)
}

final class MovieCellViewModel {
    private weak var delegate: MovieCellViewModelDelegate?
    private var movie: Search?
    
    init(delegate: MovieCellViewModelDelegate, movie: Search?) {
        self.delegate = delegate
        self.movie = movie
    }
}

extension MovieCellViewModel: MovieCellViewModelProtocol {
    func load() {
        if let movie = movie {
            delegate?.configureCell(movie: movie)
        }
    }
    
    func viewDidLoad() {
        delegate?.setUI()
    }
}
