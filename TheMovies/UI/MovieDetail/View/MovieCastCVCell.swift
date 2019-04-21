//
//  MovieCastCVCell.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class MovieCastCVCell: UICollectionViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var ivCastImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelName.font = UIFont.themeRegularFont(of: 14)
        labelName.text = ""
        labelName.textAlignment = .center
        
        ivCastImage.contentMode = .scaleAspectFill
        
        ivCastImage.layer.masksToBounds = true
        roundImage()
        
        ivCastImage.backgroundColor = UIColor.red.withAlphaComponent(0.12)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundImage()
    }
    
    func roundImage() {
        ivCastImage.layer.cornerRadius = ivCastImage.bounds.size.width/2
    }
    
    override func prepareForReuse() {
        labelName.text = ""
        ivCastImage.image = nil
    }
    
    func configure(cast: MovieCast?) {
        if let _cast = cast {
            labelName.text = _cast.name
            ivCastImage.load(url: _cast.fullProfilePath)
        }
        roundImage()
    }
    
}
