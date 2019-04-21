//
//  MovieCastTVCell.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class MovieCastTVCell: UITableViewCell {
    
    @IBOutlet weak var ivCastImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCharacter: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelName.font = UIFont.themeMediumFont(of: 18)
        labelCharacter.font = UIFont.themeRegularFont(of: 16)
        
        labelName.textColor = UIColor.black
        labelCharacter.textColor = UIColor.gray
        
        labelName.text = ""
        labelCharacter.text = ""
        
        ivCastImage.image = nil
        ivCastImage.contentMode = .scaleAspectFill
        
        ivCastImage.layer.cornerRadius = ivCastImage.bounds.width/2
        ivCastImage.layer.masksToBounds = true
        ivCastImage.backgroundColor = UIColor.red.withAlphaComponent(0.12)
        
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        labelName.text = ""
        labelCharacter.text = ""
        
        ivCastImage.image = nil
    }
    
    func configure(cast: MovieCast?) {
        if let _cast = cast {
            labelName.text = _cast.name
            labelCharacter.text = _cast.character
            ivCastImage.load(url: _cast.fullProfilePath)
        }
    }
    
    func configure(crew: MovieCrew?) {
        if let _crew = crew {
            labelName.text = _crew.name
            labelCharacter.text = "\(_crew.job) - \(_crew.department)"
            ivCastImage.load(url: _crew.fullProfilePath)
        }
    }
    
}
