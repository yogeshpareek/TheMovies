//
//  PopularMoviesVC.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 20/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class PopularMoviesVC: BaseUIViewController {
    
    @IBOutlet weak var moviesCV: UICollectionView!
    private let spacing: CGFloat = 16
    private let numberOfColumns: CGFloat = 2
    private var flowLayout: UICollectionViewFlowLayout!
    private var showCVLoadingFooter: Bool = false
    
    var presenter: PopularMoviesPresenterProtocol?
    private var movieViewModel: MovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    internal override func setUI() {
        moviesCV.delegate = self
        moviesCV.dataSource = self
        
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.tintColor = UIColor.red
        spinner.startAnimating()
        
        moviesCV.register(UINib(nibName: "UIMovieCVCell", bundle: nil), forCellWithReuseIdentifier: "MovieCVCell")
        moviesCV.register(MovieLoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MovieLoadingFooter")
        
        flowLayout = self.moviesCV.collectionViewLayout as? UICollectionViewFlowLayout ?? UICollectionViewFlowLayout()
        
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.minimumLineSpacing = spacing
        flowLayout.sectionInset = UIEdgeInsets(inset: spacing)
        flowLayout.minimumInteritemSpacing = spacing
        
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - ((numberOfColumns + 1) * spacing))/numberOfColumns
        let itemHeight: CGFloat = itemWidth * (3/2)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let favNavBtn = UIBarButtonItem(image: UIImage(named: "ic_fav_normal"), style: .plain, target: self, action: #selector(navFavTapped))
        
        navigationItem.rightBarButtonItem = favNavBtn
        
        // Set SearchController
        let searchVC = AppNavigationCordinator.shared.createSearchMoviesModule(delegate: self)
        let searchController = UISearchController(searchResultsController: searchVC)
        if #available(iOS 11, *) {
            searchController.obscuresBackgroundDuringPresentation = true
        } else {
            searchController.dimsBackgroundDuringPresentation = true
        }
        definesPresentationContext = true
        searchController.searchResultsUpdater = nil
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = searchVC as? UISearchBarDelegate
        searchController.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true

        if #available(iOS 11, *) {
            navigationItem.searchController = searchController
            //navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.titleView = searchController.view
        }
        definesPresentationContext = true
    }
    
    @objc private func navFavTapped() {
        presenter?.selectedAllFavMovie()
    }
    
}

extension PopularMoviesVC: UISearchControllerDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        guard let vc = searchController.searchResultsController as? MovieSearchResultVC, let _model = movieViewModel, let presenter = vc.presenter else {
            return
        }
        presenter.setFilterMovies(movies: _model.data)
    }
    
}

extension PopularMoviesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.movieViewModel else {
            return 0
        }
        return viewModel.moviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCell", for: indexPath) as! MovieCVCell
        guard let viewModel = self.movieViewModel else {
            return cell
        }
        let movie = viewModel.movie(at: indexPath)
        cell.configure(delegate: self, movie: movie, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if showCVLoadingFooter {
            return CGSize(width: UIScreen.main.bounds.width, height: 60)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if showCVLoadingFooter {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MovieLoadingFooter", for: indexPath) as! MovieLoadingFooterView
            return cell
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.willDisplayCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSeletMovie(at: indexPath)
    }
    
}

extension PopularMoviesVC: PopularMoviesVCProtocol {
    
    func showErrorView(type: EmptyErrorType) {
        self.showError(type: type, delegate: self)
    }
    
    func showLoading(message: String) {
        if movieViewModel == nil {
            showCVLoadingFooter = false
            showLoadingView(msg: message)
        } else {
            showCVLoadingFooter = true
            moviesCV.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func hideLoading() {
        if showCVLoadingFooter {
            showCVLoadingFooter = false
            moviesCV.reloadSections(IndexSet(integer: 0))
        } else {
            hideLoadingView()
        }
    }
   
    func showPopularMovies(viewModel: MovieViewModel) {
        self.movieViewModel = viewModel
        moviesCV.reloadSections(IndexSet(integer: 0))
    }
    
    func insertPopularMovies(at indexPaths: [IndexPath]) {
        moviesCV.performBatchUpdates({
            self.moviesCV.insertItems(at: indexPaths)
        }, completion: nil)
    }
    
    func reloadPopularMovies(at indexPaths: [IndexPath]) {
        if indexPaths.isEmpty {
            let index = moviesCV.indexPathsForVisibleItems
            moviesCV.reloadItems(at: index)
        } else {
            moviesCV.reloadItems(at: indexPaths)
        }
    }
    
}

extension PopularMoviesVC: SNEmptyStateViewDelegate {
    
    func retryBtnTapped() {
        presenter?.retryLoadPopularMovies()
    }
    
}

extension PopularMoviesVC: MovieCVCellDelegate {
    
    func movieFavTapped(for cell: MovieCVCell) {
        guard let indexPath = self.moviesCV.indexPath(for: cell) else {
            return
        }
        presenter?.selectedFav(at: indexPath)
    }
    
}

extension PopularMoviesVC: MovieSearchResultVCDelegate {
   
    func movieSeachVC(tappedMovie index: IndexPath) {
        presenter?.didSeletMovie(at: index)
    }
    
}
