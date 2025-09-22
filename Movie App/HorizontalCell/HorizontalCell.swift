//
//  HorizontalCell.swift
//  Movie App
//
//  Created by Latif Atci on 8.09.2025.
//

import UIKit

class HorizontalCell: UICollectionViewCell {

   
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    
    private lazy var viewModel: HorizontalCellViewModelProtocol = HorizontalCellViewModel(delegate: self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.awakeFromNib()
    }

}
 
extension HorizontalCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: MovieCell.self, indexPath: indexPath)
        let movie = viewModel.movieAtIndex(index: indexPath.item)
        let cellViewModel = MovieCellViewModel(delegate: cell, movie: movie)
        cell.viewModel = cellViewModel
        return cell
    }
}

extension HorizontalCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(index: indexPath.item)
        viewModel.sendSelectedCell()
    }
}

extension HorizontalCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 155, height: 255)
    }
}
                                
extension HorizontalCell: HorizontalCellViewModelDelegate {

    func reloadData() {
        horizontalCollectionView.reloadData()
    }
    
    func prepareCollectionView() {
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.register(cellType: MovieCell.self)
    }
}
