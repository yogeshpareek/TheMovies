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
        cell.configure(movie: movie)
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
    
}

extension PopularMoviesVC: PopularMoviesVCProtocol {
   
    func showLoading(message: String) {
        if movieViewModel == nil {
            showCVLoadingFooter = false
            showLoadingView(msg: message)
        } else {
            showCVLoadingFooter = false
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
    
}
