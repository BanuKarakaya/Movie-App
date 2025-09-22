//
//  HomeViewModel.swift
//  Movie App
//
//  Created by Banu on 1.09.2025.
//

import Foundation

protocol HomeViewModelProtocol {
    func viewDidLoad()
    func movieAtIndex(index: Int) -> Search?
    func numberOfItems() -> Int
    func didSelectItemAt(index: Int)
    func searchBarCancelButtonClicked()
    func searchBarSearchButtonClicked(searchText: String?)
}

protocol HomeViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func setUI()
    func prepareSearchBar()
    func reloadData()
    func emptyViewHidden(hidden: Bool)
    func navigateToDetailVC(selectedCell: Search?)
}

final class HomeViewModel {
    private weak var delegate: HomeViewModelDelegate?
    var movies: [Search]?
    var searchMovies: [Search]?
    private let networkManager: NetworkManagerInterface
    var isSearching = false
    
    init(delegate: HomeViewModelDelegate?, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
    }
    
    func fetchMovies() {
        networkManager.getMovies { responseData in
            switch responseData {
            case .success(let responseData):
                self.movies = responseData.search
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
    
    func fetchSearchMovies(searchText: String) {
        networkManager.getSearchMovies(completion: { responseData in
            switch responseData {
            case .success(let responseData):
                self.searchMovies = responseData.search
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
                print(responseData)
                break
            case .failure(let error):
                print(error)
                break
            }
        }, searchText: searchText)
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func searchBarCancelButtonClicked() {
        isSearching = false
        delegate?.reloadData()
        searchMovies = nil
        delegate?.emptyViewHidden(hidden: true)
    }
    
    func searchBarSearchButtonClicked(searchText: String?) {
        if let searchText = searchText {
            isSearching = true
            fetchSearchMovies(searchText: searchText)
            delegate?.reloadData()
        }
        
        if searchMovies == nil {
            delegate?.emptyViewHidden(hidden: false)
        } else if searchMovies!.count > 0 {
            delegate?.emptyViewHidden(hidden: true)
        }
    }
    
    func didSelectItemAt(index: Int) {
        var selectedCell: Search?
        
        if isSearching {
            selectedCell = searchMovies?[index]
        } else {
            selectedCell = movies?[index]
        }
        print(selectedCell?.title)
        delegate?.navigateToDetailVC(selectedCell: selectedCell)
    }
    
    func numberOfItems() -> Int {
        return (isSearching ? searchMovies?.count : movies?.count)  ?? .zero
    }
    
    func movieAtIndex(index: Int) -> Search? {
        if isSearching {
            if let movie = searchMovies?[index] {
                return movie
            }
        } else {
            if let movie = movies?[index] {
                return movie
            }
        }
        return nil
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.setUI()
        fetchMovies()
        delegate?.prepareSearchBar()
    }
}
