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
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: MovieCell.self, indexPath: indexPath)
        return cell
    }
}

extension HorizontalCell: UICollectionViewDelegate {
    
}

extension HorizontalCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 155, height: 255)
    }
}
                                
extension HorizontalCell: HorizontalCellViewModelDelegate {
    func prepareCollectionView() {
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.register(cellType: MovieCell.self)
    }
}
