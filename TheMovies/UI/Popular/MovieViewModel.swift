//
//  MovieViewModel.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

class MovieViewModel: PaginationViewModel<Movie> {
    
    override init(pageSize: Int = 20) {
        super.init(pageSize: pageSize)
    }
    
    public func movie(at indexPath: IndexPath) -> Movie {
        return data[indexPath.row]
    }
    
    var moviesCount: Int {
        return data.count
    }
    
}
