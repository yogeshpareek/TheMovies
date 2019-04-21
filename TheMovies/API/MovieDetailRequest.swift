//
//  MovieDetailRequest.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

class MovieDetailRequest: APIRequest<MovieDetail> {
    
    init(id: Int) {
        super.init(route: MovieRoute.movieDetail(id: id).asRoute)
    }
    
    override func getParameters() -> [String : Any] {
        return [
            "append_to_response": "credits"
        ]
    }
    
}
