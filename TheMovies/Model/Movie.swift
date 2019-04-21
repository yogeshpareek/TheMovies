//
//  Movie.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 20/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

class Movie: Codable {
    
    var voteCount: Int = 0
    var id: Int = 0
    var video: Bool = false
    var voteAverage: Float = 0.0
    var title: String = ""
    var popularity: Float = 0.0
    var posterPath: String = ""
    var originalLanguage: String = ""
    var originalTitle: String = ""
    var genreIds: [Int] = []
    var backdropPath: String = ""
    var adult: Bool = false
    var overview: String = ""
    var releaseDate: String = ""
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id
        case video
        case voteAverage = "vote_average"
        case title
        case popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case releaseDate = "release_date"
    }
    
}
