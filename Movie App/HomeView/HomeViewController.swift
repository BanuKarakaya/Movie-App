//
//  HomeViewController.swift
//  Movie App
//
//  Created by Banu on 1.09.2025.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
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
                  return 8
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
            let cellViewModel = MovieCellViewModel(delegate: cell)
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
        .init(top: 10, left: 25, bottom: 10, right: 25)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func setUI() {
        self.title = "Movies"
    }
    
    func prepareCollectionView() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.register(cellType: MovieCell.self)
        homeCollectionView.register(cellType: HorizontalCell.self)
    }
}
