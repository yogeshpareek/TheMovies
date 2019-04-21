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
    
    private var moviesViewModel: MovieViewModel = MovieViewModel(pageSize: 20)
    
    func willDisplayCell(at indexPath: IndexPath) {
        if moviesViewModel.canLoadNow(index: indexPath.row) {
            loadPopularMovies()
        }
    }
    
    func viewDidLoad() {
        loadPopularMovies()
    }
    
    func viewWillAppear() {
        
    }
    
    private func loadPopularMovies() {
        if moviesViewModel.isLoading {
            return
        }
        moviesViewModel.start()
        view?.showLoading(message: "Loading...")
        interactor?.makePopularMoviesRequest(page: moviesViewModel.page)
    }
    
}

extension PopularMoviesPresenter: PopularMoviesOutputInteractorProtocol {
    
    func onPopularMoviesSuccess(response: PopularMoviesResponse) {
        view?.hideLoading()
        moviesViewModel.success(objects: response.results)
        view?.showPopularMovies(viewModel: moviesViewModel)
    }
    
    func onPopularMoviesError(error: APIError) {
        view?.hideLoading()
        moviesViewModel.failed()
        view?.showErrorView(type: .Custom(title: nil, desc: error.description, image: Image.icEmptyState.image, btnAction: "Retry"))
    }
    
}
