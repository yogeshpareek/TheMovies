//
//  MovieRoute.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 20/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation



enum MovieRoute {
    case popularMovies
    case movieDetail(id: Int)
}

extension MovieRoute {
    
    private var baseUrl: String {
        return Constant.MOVIE_DB_BASE_PATH
    }
    
    private var apiEndPoint: String {
        return "\(baseUrl)/\(urlPath)?api_key=\(Constant.API_KEY)"
    }
    
    private var urlPath: String {
        switch self {
        case .popularMovies:
            return "movie/popular"
        case .movieDetail(let id):
            return "movie/\(id)"
        }
    }
    
    var url: URL {
        return URL(string: apiEndPoint)!
    }
    
    var asRoute: Route {
        switch self {
        case .popularMovies:
            return Route.getRoute(path: apiEndPoint)
        case .movieDetail:
            return Route.getRoute(path: apiEndPoint)
        }
    }
    
}
