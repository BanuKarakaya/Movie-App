//
//  HorizontalCellViewModel.swift
//  Movie App
//
//  Created by Latif Atci on 8.09.2025.
//

import Foundation

protocol HorizontalCellViewModelProtocol {
    func awakeFromNib()
    func movieAtIndex(index: Int) -> Search?
    func numberOfItems() -> Int?
    func didSelectItemAt(index: Int)
    func sendSelectedCell()
}

protocol HorizontalCellViewModelDelegate: AnyObject {
   func prepareCollectionView()
   func reloadData()
}

final class HorizontalCellViewModel {
    private weak var delegate: HorizontalCellViewModelDelegate?
    var populerMovies: [Search]?
    private let networkManager: NetworkManagerInterface
    var selectedCell: Search?
    
    init(delegate: HorizontalCellViewModelDelegate?, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
    }
    
    func fetchMovies() {
        networkManager.getPopuler { responseData in
            switch responseData {
            case .success(let responseData):
                self.populerMovies = responseData.search
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
                print(responseData)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

extension HorizontalCellViewModel: HorizontalCellViewModelProtocol {
    func sendSelectedCell() {
        let selectedCell: [String: Search?] = ["selectedCell": selectedCell]
        NotificationCenter.default.post(name: .populerCellTapped, object: nil, userInfo: selectedCell as [AnyHashable : Any])
    }
    
    func didSelectItemAt(index: Int) {
        selectedCell = populerMovies?[index]
    }
    
    func numberOfItems() -> Int? {
        return populerMovies?.count ?? 0
    }
    
    func movieAtIndex(index: Int) -> Search? {
        if let movie = populerMovies?[index] {
            return movie
        }
        return nil
    }
    
    func awakeFromNib() {
        delegate?.prepareCollectionView()
        fetchMovies()
    }
}
