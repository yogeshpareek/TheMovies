//
//  MovieDetailViewModel.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    
    private(set) var movieDetail: MovieDetail
    
    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
    }
    
    var castCount: Int {
        return self.movieDetail.credits?.cast.count ?? 0
    }
    
    var crewCount: Int {
        return self.movieDetail.credits?.crew.count ?? 0
    }
    
    func cast(at indexPath: IndexPath) -> MovieCast? {
        return self.movieDetail.credits?.cast[indexPath.row]
    }
    
    func crew(at indexPath: IndexPath) -> MovieCrew? {
        return self.movieDetail.credits?.crew[indexPath.row]
    }
    
    var movieGenre: String {
        return movieDetail.genres.map { $0.name }.joined(separator: ", ")
    }
    
    var ratingText: String {
        return "\(movieDetail.voteAverage) (\(movieDetail.voteCount) Reviews)"
    }
    
    var releaseText: String {
        return "\(movieDetail.releaseDate.formatDateMediumStyle(dateFormat: "yyyy-MM-dd")) \(movieDetail.status)"
    }
    
}

extension String {
    
    func formatDateMediumStyle(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        
        let date = formatter.date(from: self)
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dateString = formatter.string(from: date!)
        
        return dateString
    }
    
}
