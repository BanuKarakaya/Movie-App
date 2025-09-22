//
//  HomeViewController.swift
//  Movie App
//
//  Created by Banu on 1.09.2025.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(populerCellToDetail(_:)), name: .populerCellTapped, object: nil)

    }
    
    @objc func populerCellToDetail(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let selectedCell = dict["selectedCell"] as? Search {
                let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                let detailVM = DetailViewModel(delegate: detailVC)
                detailVM.selectedMovie = selectedCell
                detailVC.viewModel = detailVM
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
              case 0:
                  return 1
              case 1:
            return viewModel.numberOfItems()
              default:
                  return 8
              }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeCell(cellType: HorizontalCell.self, indexPath: indexPath)
            return cell
        } else  {
            let cell = collectionView.dequeCell(cellType: MovieCell.self, indexPath: indexPath)
            let movie = viewModel.movieAtIndex(index: indexPath.item)
            let cellViewModel = MovieCellViewModel(delegate: cell, movie: movie)
            cell.viewModel = cellViewModel
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
              case 0:
                  return CGSize(width: 393, height: 300)
              case 1:
                  return CGSize(width: 155, height: 255)
              default:
                  return CGSize(width: 155, height: 255)
              }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return .init(top: 10, left: 10, bottom: 10, right: 10)
        case 1:
            return .init(top: 10, left: 25, bottom: 10, right: 25)
        default:
            return .init(top: 10, left: 25, bottom: 10, right: 25)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("banu")
        case 1:
            viewModel.didSelectItemAt(index: indexPath.item)
        default:
            viewModel.didSelectItemAt(index: indexPath.item)
        }
        
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("banu")
        viewModel.searchBarSearchButtonClicked(searchText: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchBarCancelButtonClicked()
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func emptyViewHidden(hidden: Bool) {
        emptyView.isHidden = hidden
    }
    
    func prepareSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .tintColor
        
        searchController.searchBar.delegate = self
    }
    
    func navigateToDetailVC(selectedCell: Search?) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let detailViewModel = DetailViewModel(delegate: detailVC)
        detailVC.viewModel = detailViewModel
        detailViewModel.selectedMovie = selectedCell
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func reloadData() {
        homeCollectionView.reloadData()
    }
    
    func setUI() {
        self.title = "Movies"
        emptyView.isHidden = true
    }
    
    func prepareCollectionView() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.register(cellType: MovieCell.self)
        homeCollectionView.register(cellType: HorizontalCell.self)
    }
}
