//
//  MovieSearchProtocols.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 24/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

protocol MovieSearchWireFrameProtocol: class {
    func dismiss(view: MovieSearchVCProtocol)
}

protocol MovieSearchVCProtocol: BaseView {
    var presenter: MovieSearchPresenterProtocol? { get set }
    
    func showSearchResult(movies: [Movie])
}

protocol MovieSearchPresenterProtocol: BasePresenter {
    var view: MovieSearchVCProtocol? { get set }
    var interactor: MovieSearchInputInteractorProtocol? { get set }
    var wireFrame: MovieSearchWireFrameProtocol? { get set }

    func setFilterMovies(movies: [Movie])
    func searchMovie(searchText: String)
    func didSeletMovie(indexPath: IndexPath)
    func selectedFav(at indexPath: IndexPath)
}

protocol MovieSearchInputInteractorProtocol: class {
    var presenter: MovieSearchOutputInteractorProtocol? { get set }
    
    func toogleFav(movie: Movie)
}

protocol MovieSearchOutputInteractorProtocol: class {
   
}
