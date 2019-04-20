//
//  MovieCVCell.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 20/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class MovieCVCell: UICollectionViewCell {
    
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var layerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        
        labelName.numberOfLines = 2
        labelName.font = UIFont.themeBoldFont(of: 18)
        labelName.textColor = UIColor.white
        
        layerView.backgroundColor = UIColor.purple.withAlphaComponent(0.12)
    }

}
