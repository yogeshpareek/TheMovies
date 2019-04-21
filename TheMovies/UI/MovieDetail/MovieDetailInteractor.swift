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
