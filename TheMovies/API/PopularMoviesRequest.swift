//
//  PopularMovieRequest.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 20/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

class PopularMoviesResponse: Codable {
    
    var page: Int = 1
    var totalResults: Int = 0
    var totalPages: Int = 0
    var results: [Movie] = []
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
}

class PopularMoviesRequest: APIRequest<PopularMoviesResponse> {
    
    private var page: Int = 1
    
    init(page: Int) {
        super.init(route: MovieRoute.popularMovies.asRoute)
        self.page = page
    }
    
    override func getParameters() -> [String : Any] {
        return [
            "page": self.page
        ]
    }
    
}
