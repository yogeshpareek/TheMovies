//
//  PopularProtocols.swift
//  Movies
//
//  Created by Yogesh Pareek on 19/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

protocol PopularMoviesWireFrameProtocol: class {
    func pushMovieDetailVC(view: PopularMoviesVCProtocol, movie: Movie)
    func pushAllFavMoviesVC(view: PopularMoviesVCProtocol)
}

protocol PopularMoviesVCProtocol: BaseView {
    var presenter: PopularMoviesPresenterProtocol? { get set }
    
    func showPopularMovies(viewModel: MovieViewModel)
    func insertPopularMovies(at indexPaths: [IndexPath])
    func reloadPopularMovies(at indexPaths: [IndexPath])
}

protocol PopularMoviesPresenterProtocol: BasePresenter {
    var view: PopularMoviesVCProtocol? { get set }
    var interactor: PopularMoviesInputInteractorProtocol? { get set }
    var wireFrame: PopularMoviesWireFrameProtocol? { get set }
    
    func retryLoadPopularMovies()
    func willDisplayCell(at indexPath: IndexPath)
    func didSeletMovie(at indexPath: IndexPath)
    func selectedAllFavMovie()
    func selectedFav(at indexPath: IndexPath)
}

protocol PopularMoviesInputInteractorProtocol: class {
    var presenter: PopularMoviesOutputInteractorProtocol? { get set }
    
    func makePopularMoviesRequest(page: Int)
    func toogleFav(movie: Movie)
    func isFav(movie: Movie) -> Bool
}

protocol PopularMoviesOutputInteractorProtocol: class {
    func onPopularMoviesSuccess(response: PopularMoviesResponse)
    func onPopularMoviesError(error: APIError)
}
