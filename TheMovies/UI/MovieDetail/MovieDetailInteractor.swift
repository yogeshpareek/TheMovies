//
//  MovieDetailInteractor.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

class MovieDetailInteractor: MovieDetailInputInteractorProtocol {
    
    weak var presenter: MovieDetailOutputInteractorProtocol?
    private var favManager: MovieFavManager
    
    init(manager: MovieFavManager) {
        self.favManager = manager
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
    
    func makeMovieDetailRequest(id: Int) {
        MovieDetailRequest(id: id).response { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.presenter?.onMovieDetailSuccess(response: response)
                break
            case .failure(let error):
                self?.presenter?.onMovieDetailError(error: error)
                break
            }
        }
    }
}
