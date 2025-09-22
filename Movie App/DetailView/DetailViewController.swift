//
//  DetailViewController.swift
//  Movie App
//
//  Created by Latif Atci on 8.09.2025.
//

import UIKit

final class DetailViewController: UIViewController {

    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    
    lazy var viewModel: DetailViewModelProtocol = DetailViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func configure(selectedMovie: Search?) {
        movieName.text = selectedMovie?.title
        movieYear.text = selectedMovie?.year
        prepareBannerImage(with: selectedMovie?.poster)
    }
    
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            movieImage.sd_setImage(with: url)
        }
    }
    
    func prepareUI() {
        movieImage.layer.cornerRadius = 12
    }
}
