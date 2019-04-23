//
//  MovieCVCell.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 20/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

protocol MovieCVCellDelegate {
    func movieFavTapped(for cell: MovieCVCell)
}

class MovieCVCell: UICollectionViewCell {
    
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var btnFav: UIButton!
    
    private var delegate: MovieCVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        
        labelName.numberOfLines = 2
        labelName.font = UIFont.themeBoldFont(of: 18)
        labelName.textColor = UIColor.white
        ivMovie.image = nil
        self.contentView.backgroundColor = UIColor.lightText
        
        layerView.backgroundColor = UIColor.purple.withAlphaComponent(0.12)
        
        btnFav.addTarget(self, action: #selector(btnFavTapped), for: .touchUpInside)
    }
    
    override func prepareForReuse() {
        labelName.text = nil
        ivMovie.image = nil
    }
    
    public func configure(delegate: MovieCVCellDelegate, movie: Movie, indexPath: IndexPath) {
        self.delegate = delegate
        labelName.text = movie.title
        ivMovie.load(url: movie.fullPosterPath, indexPath: indexPath)
        btnFav.isSelected = movie.isFav
    }
    
    public func configure(delegate: MovieCVCellDelegate, movie: FavMovie, indexPath: IndexPath) {
        self.delegate = delegate
        labelName.text = movie.name
        ivMovie.load(url: movie.moviePosterPath, indexPath: indexPath)
        btnFav.isSelected = true
    }
    
    @objc private func btnFavTapped() {
        btnFav.isSelected = !btnFav.isSelected
        delegate?.movieFavTapped(for: self)
    }

}
