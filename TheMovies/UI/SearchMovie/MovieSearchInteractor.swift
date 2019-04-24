//
//  MovieSearchInteractor.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 24/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

class MovieSearchInteractor: MovieSearchInputInteractorProtocol {
    
    weak var presenter: MovieSearchOutputInteractorProtocol?
    private var favManager: MovieFavManager
    
    init(manager: MovieFavManager) {
        self.favManager = manager
    }
    
    func toogleFav(movie: Movie) {
        favManager.toggleFav(movie: movie)
    }
    
}
