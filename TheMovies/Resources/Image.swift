//
//  Image.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

enum Image: String {
    case icEmptyState = "ic_empty_state"
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
