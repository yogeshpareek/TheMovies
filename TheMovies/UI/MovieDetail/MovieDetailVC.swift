//
//  MovieDetail.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class MovieDetailVC: BaseUIViewController {
    
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var btnRating: UIButton!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var svActionBtn: UIStackView!
    @IBOutlet weak var _labelOverviewTitle: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var btnOverviewMore: UIButton!
    @IBOutlet weak var _labelCastTitle: UILabel!
    @IBOutlet weak var btnCastViewAll: UIButton!
    @IBOutlet weak var cvCast: UICollectionView!
    
    var presenter: MovieDetailPresenterProtocol?
    var movieViewModel: MovieDetailViewModel?
    private var flowLayout: UICollectionViewFlowLayout!
    private var overviewExpanded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func setUI() {
        cvCast.delegate = self
        cvCast.dataSource = self
        
        cvCast.register(UINib(nibName: "UIMovieCastCVCell", bundle: nil), forCellWithReuseIdentifier: "MovieCastCVCell")
        
        labelName.numberOfLines = 2
        labelGenre.numberOfLines = 0
        
        btnCastViewAll.setTitle("View All", for: .normal)
        btnOverviewMore.setTitle("More", for: .normal)
        _labelCastTitle.text = "Cast"
        _labelOverviewTitle.text = "Overview"
        
        flowLayout = self.cvCast.collectionViewLayout as? UICollectionViewFlowLayout ?? UICollectionViewFlowLayout()
        
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(inset: 0)
        flowLayout.minimumInteritemSpacing = 0
        
        let itemSize: CGFloat = (UIScreen.main.bounds.width - 40)/4
        flowLayout.itemSize = CGSize(width: itemSize, height: itemSize)


        btnCastViewAll.addTarget(self, action: #selector(btnCastViewAllTapped), for: .touchUpInside)
        btnOverviewMore.addTarget(self, action: #selector(btnOverviewMoreTapped), for: .touchUpInside)
    }
    
    override func setUITheme() {
        labelName.font = UIFont.themeBoldFont(of: 24)
        _labelOverviewTitle.font = UIFont.themeMediumFont(of: 20)
        labelOverview.font = UIFont.themeRegularFont(of: 16)
        _labelCastTitle.font = UIFont.themeMediumFont(of: 20)
        
        btnOverviewMore.titleLabel?.font = UIFont.themeRegularFont(of: 14)
        btnCastViewAll.titleLabel?.font = UIFont.themeRegularFont(of: 14)
        
        btnRating.titleLabel?.font = UIFont.themeRegularFont(of: 15)
        btnTime.titleLabel?.font = UIFont.themeRegularFont(of: 15)
        
        btnOverviewMore.setTitleColor(UIColor.purple, for: .normal)
        btnCastViewAll.setTitleColor(UIColor.purple, for: .normal)
        
        ivMovie.backgroundColor = UIColor.purple.withAlphaComponent(0.12)
        
        btnRating.setTitleColor(UIColor.darkText, for: .normal)
        btnTime.setTitleColor(UIColor.darkGray, for: .normal)
        btnRating.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        btnRating.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        btnTime.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        labelTime.font = UIFont.themeRegularFont(of: 16)
        labelReleaseDate.font = UIFont.themeRegularFont(of: 16)
        labelGenre.font = UIFont.themeRegularFont(of: 16)
        
        labelOverview.textColor = UIColor.darkText
        _labelOverviewTitle.textColor = UIColor.black
        
        _labelCastTitle.textColor = UIColor.black
        
        labelReleaseDate.textColor = UIColor.darkText
        labelTime.textColor = UIColor.darkText
        labelGenre.textColor = UIColor.darkText

        ivMovie.layer.cornerRadius = 8
        ivMovie.layer.masksToBounds = true
    }
    
    @objc private func btnCastViewAllTapped() {
        presenter?.viewAllCast()
    }
    
    @objc private func btnOverviewMoreTapped() {
        overviewExpanded = !overviewExpanded
        labelOverview.numberOfLines = overviewExpanded ? 0 : 3
        btnOverviewMore.setTitle(overviewExpanded ? "Less" : "More", for: .normal)
    }
    
}

extension MovieDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewmodel = movieViewModel else {
            return 0
        }
        let count = viewmodel.castCount
        return count > 4 ? 4 : count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCVCell", for: indexPath) as! MovieCastCVCell
        cell.configure(cast: movieViewModel?.cast(at: indexPath))
        return cell
    }
    
}

extension MovieDetailVC: MovieDetailVCProtocol {
    
    func showMovieDetail(viewModel: MovieDetailViewModel) {
        self.movieViewModel = viewModel
        labelOverview.text = viewModel.movieDetail.overview
        labelName.text = viewModel.movieDetail.title
        ivMovie.load(url: viewModel.movieDetail.fullPosterPath)
        
        labelGenre.text = viewModel.movieGenre
        labelReleaseDate.text = viewModel.releaseText
        labelTime.text = "Duration: \(viewModel.movieDetail.runtime) mins"
        btnTime.isHidden = true
        
        btnRating.setTitle(viewModel.ratingText, for: .normal)
        btnTime.setTitle("\(viewModel.movieDetail.runtime) mins", for: .normal)
        
        cvCast.reloadData()
    }
}
