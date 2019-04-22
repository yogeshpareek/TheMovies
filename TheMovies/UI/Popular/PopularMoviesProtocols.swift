//
//  PopularProtocols.swift
//  Movies
//
//  Created by Yogesh Pareek on 19/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

protocol PopularMoviesWireFrameProtocol: class {
    func pushMovieDetail(view: PopularMoviesVCProtocol, movie: Movie)
}

protocol PopularMoviesVCProtocol: BaseView {
    var presenter: PopularMoviesPresenterProtocol? { get set }
    
    func showPopularMovies(viewModel: MovieViewModel)
    func insertPopularMovies(at indexPaths: [IndexPath])
}

protocol PopularMoviesPresenterProtocol: BasePresenter {
    var view: PopularMoviesVCProtocol? { get set }
    var interactor: PopularMoviesInputInteractorProtocol? { get set }
    var wireFrame: PopularMoviesWireFrameProtocol? { get set }
    
    func retryLoadPopularMovies()
    func willDisplayCell(at indexPath: IndexPath)
    func didSeletMovie(at indexPath: IndexPath)
}

protocol PopularMoviesInputInteractorProtocol: class {
    var presenter: PopularMoviesOutputInteractorProtocol? { get set }
    
    func makePopularMoviesRequest(page: Int)
}

protocol PopularMoviesOutputInteractorProtocol: class {
    func onPopularMoviesSuccess(response: PopularMoviesResponse)
    func onPopularMoviesError(error: APIError)
}
