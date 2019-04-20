//
//  PopularMoviesVC.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 20/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class PopularMoviesVC: UIViewController {
    
    @IBOutlet weak var moviesCV: UICollectionView!
    private let spacing: CGFloat = 16
    private let numberOfColumns: CGFloat = 2
    private var flowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        setUI()
    }
    
    private func setUI() {
        moviesCV.delegate = self
        moviesCV.dataSource = self
        
        moviesCV.register(UINib(nibName: "UIMovieCVCell", bundle: nil), forCellWithReuseIdentifier: "MovieCVCell")
        
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

extension PopularMoviesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCell", for: indexPath) as! MovieCVCell
        cell.labelName.text = "Avenger Endgame"
        return cell
    }
    
}
