//
//  FavMovieVC.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 22/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class FavMovieVC: BaseUIViewController {
    
    private var favManager: MovieFavManager = MovieFavManager.shared
    private var allFavs: [FavMovie] = []
    private var lastSelectedIndexPath: IndexPath?
    private var lastSelectedMovie: Movie?
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - (3 * spacing)) / 2
        let itemHeight: CGFloat = itemWidth * (3/2)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(inset: spacing)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favourite Movies"
        allFavs.append(contentsOf: favManager.fetchAll())
        
        view.addSubview(collectionView)
        collectionView.register(UINib(nibName: "UIMovieCVCell", bundle: nil), forCellWithReuseIdentifier: "MovieCVCell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
        
        showFavsEmpty()
    }
    
    private func showFavsEmpty() {
        if allFavs.isEmpty {
            showError(type: .Custom(title: "Favourite Movies Empty", desc: "All your favourite marked movies will be shown here.", image: Image.icEmptyState.image, btnAction: nil))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = lastSelectedIndexPath, let movie = lastSelectedMovie {
            if !movie.isFav {
                removeFav(at: indexPath)
            }
            lastSelectedIndexPath = nil
            lastSelectedMovie = nil
        }
    }
    
    private func didSeletMovie(at indexPath: IndexPath) {
        let movie = Movie(movie: allFavs[indexPath.row])
        lastSelectedIndexPath = indexPath
        lastSelectedMovie = movie
        let vc = AppNavigationCordinator.shared.createMovieDetailModule(movie: movie)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FavMovieVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFavs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCell", for: indexPath) as! MovieCVCell
        let movie = allFavs[indexPath.row]
        cell.configure(delegate: self, movie: movie, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSeletMovie(at: indexPath)
    }
    
}

extension FavMovieVC: MovieCVCellDelegate {
    
    func movieFavTapped(for cell: MovieCVCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
            return
        }
        removeFav(at: indexPath)
    }
    
    private func removeFav(at indexPath: IndexPath) {
        favManager.remove(objectID: allFavs[indexPath.row].objectID)
        allFavs.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
        showFavsEmpty()
    }
    
}
