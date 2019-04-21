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
}
