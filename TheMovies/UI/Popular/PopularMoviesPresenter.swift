//
//  PopularMoviesPresenter.swift
//  Movies
//
//  Created by Yogesh Pareek on 19/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

class PopularMoviesPresenter: PopularMoviesPresenterProtocol {
    
    weak var view: PopularMoviesVCProtocol?
    var interactor: PopularMoviesInputInteractorProtocol?
    var wireFrame: PopularMoviesWireFrameProtocol?
    
}

extension PopularMoviesPresenter: PopularMoviesOutputInteractorProtocol {
    
}
