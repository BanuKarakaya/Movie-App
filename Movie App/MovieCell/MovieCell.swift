//
//  MovieCell.swift
//  Movie App
//
//  Created by Latif Atci on 8.09.2025.
//

import UIKit
import SDWebImage

final class MovieCell: UICollectionViewCell {
   
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    var viewModel: MovieCellViewModelProtocol! {
        didSet {
            viewModel.viewDidLoad()
            viewModel.load()
        }
    }
}

extension MovieCell: MovieCellViewModelDelegate {
    
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            movieImage.sd_setImage(with: url)
        }
    }
    
    func configureCell(movie: Search?) {
        movieName.text = movie?.title
        movieYear.text = movie?.year
        prepareBannerImage(with: movie?.poster)
    }
    
    func setUI() {
        self.layer.cornerRadius = 10
    }
}
