//
//  PropularMoviesInteractor.swift
//  Movies
//
//  Created by Yogesh Pareek on 19/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

class PopularMoviesInteractor: PopularMoviesInputInteractorProtocol {
    
    weak var presenter: PopularMoviesOutputInteractorProtocol?
    private var favManager: MovieFavManager
    
    init(manager: MovieFavManager) {
        self.favManager = manager
    }
    
    func makePopularMoviesRequest(page: Int) {
        PopularMoviesRequest(page: page).response { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.presenter?.onPopularMoviesSuccess(response: response)
                break
            case .failure(let error):
                self?.presenter?.onPopularMoviesError(error: error)
                break
            }
        }
    }
    
    func toogleFav(movie: Movie) {
        if let fav = favManager.isFav(movie: movie) {
            //favManager.remove(favMovie: fav)
            favManager.remove(objectID: fav.objectID)
        } else {
            favManager.insertFavMovie(movie: movie)
        }
    }
    
    func isFav(movie: Movie) -> Bool {
        if favManager.isFav(movie: movie) != nil {
            return true
        }
        return false
    }
    
}
