//
//  MovieDetailPresenter.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    weak var view: MovieDetailVCProtocol?
    var interactor: MovieDetailInputInteractorProtocol?
    var wireFrame: MovieDetailWireFrameProtocol?
    
    private var movieDetailViewModel: MovieDetailViewModel?
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func viewDidLoad() {
        loadMovieDetail()
    }
    
    func viewWillAppear() {
        
    }
    
    private func loadMovieDetail() {
        view?.showLoading(message: "Loading...")
        interactor?.makeMovieDetailRequest(id: movie.id)
    }
    
    func viewAllCast() {
        if let model = movieDetailViewModel {
            wireFrame?.pushMovieCastVC(view: view!, model: model)
        }
    }
    
}

extension MovieDetailPresenter: MovieDetailOutputInteractorProtocol {
    
    func onMovieDetailSuccess(response: MovieDetail) {
        view?.hideLoading()
        movieDetailViewModel = MovieDetailViewModel(movieDetail: response)
        view?.showMovieDetail(viewModel: movieDetailViewModel!)
    }
    
    func onMovieDetailError(error: APIError) {
        view?.hideLoading()
        view?.showErrorView(type: .Custom(title: nil, desc: error.description, image: Image.icEmptyState.image, btnAction: "Retry"))
    }
    
}
