//
//  HorizontalCellViewModel.swift
//  Movie App
//
//  Created by Latif Atci on 8.09.2025.
//

import Foundation

protocol HorizontalCellViewModelProtocol {
    func awakeFromNib()
}

protocol HorizontalCellViewModelDelegate: AnyObject {
   func prepareCollectionView()
}

final class HorizontalCellViewModel {
    private weak var delegate: HorizontalCellViewModelDelegate?
    
    init(delegate: HorizontalCellViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension HorizontalCellViewModel: HorizontalCellViewModelProtocol {
    func awakeFromNib() {
        delegate?.prepareCollectionView()
    }
}
