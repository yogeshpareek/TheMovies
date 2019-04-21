//
//  MovieCredit.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

class MovieCredit: Decodable {
    var cast: [MovieCast] = []
    var crew: [MovieCrew] = []
    
}
