//
//  PopularProtocols.swift
//  Movies
//
//  Created by Yogesh Pareek on 19/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

protocol PopularMoviesWireFrameProtocol: class {
    func pushMovieDetail(view: PopularMoviesVCProtocol)
}

protocol PopularMoviesVCProtocol: class {
    var presenter: PopularMoviesPresenterProtocol? { get set }
    
}

protocol PopularMoviesPresenterProtocol: class {
    var view: PopularMoviesVCProtocol? { get set }
    var interactor: PopularMoviesInputInteractorProtocol? { get set }
    var wireFrame: PopularMoviesWireFrameProtocol? { get set }
}

protocol PopularMoviesInputInteractorProtocol: class {
    var presenter: PopularMoviesOutputInteractorProtocol? { get set }
}

protocol PopularMoviesOutputInteractorProtocol: class {
    
}
