//
//  MovieCell.swift
//  Movie App
//
//  Created by Latif Atci on 8.09.2025.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImage!
    @IBOutlet weak var movieName: UILabel!
    
    var viewModel: MovieCellViewModelProtocol! {
        didSet {
            viewModel.viewDidLoad()
        }
    }
}

extension MovieCell: MovieCellViewModelDelegate {
    func setUI() {
        self.layer.cornerRadius = 10
    }
}
