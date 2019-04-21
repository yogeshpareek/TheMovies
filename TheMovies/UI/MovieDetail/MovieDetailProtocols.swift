//
//  MovieDetailProtocols.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

protocol MovieDetailWireFrameProtocol: class {
    func pushMovieCastVC(view: MovieDetailVCProtocol, model: MovieDetailViewModel)
}

protocol MovieDetailVCProtocol: BaseView {
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func showMovieDetail(viewModel: MovieDetailViewModel)
}

protocol MovieDetailPresenterProtocol: BasePresenter {
    var view: MovieDetailVCProtocol? { get set }
    var interactor: MovieDetailInputInteractorProtocol? { get set }
    var wireFrame: MovieDetailWireFrameProtocol? { get set }

    func viewAllCast()
}

protocol MovieDetailInputInteractorProtocol: class {
    var presenter: MovieDetailOutputInteractorProtocol? { get set }
    
    func makeMovieDetailRequest(id: Int)
}

protocol MovieDetailOutputInteractorProtocol: class {
    func onMovieDetailSuccess(response: MovieDetail)
    func onMovieDetailError(error: APIError)
}
