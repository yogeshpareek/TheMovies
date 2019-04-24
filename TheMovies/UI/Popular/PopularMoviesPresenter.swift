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
    private var lastSelectedIndexPath: IndexPath?
    
    func willDisplayCell(at indexPath: IndexPath) {
        if moviesViewModel.canLoadNow(index: indexPath.row) {
            loadPopularMovies()
        }
    }
    
    func viewDidLoad() {
        loadPopularMovies()
    }
    
    func viewWillAppear() {
        if let indexPath = lastSelectedIndexPath {
            view?.reloadPopularMovies(at: [indexPath])
            lastSelectedIndexPath = nil
        } else {
            _ = moviesViewModel.data.map {
                $0.isFav = interactor?.isFav(movie: $0) ?? false
            }
            view?.reloadPopularMovies(at: [])
        }
    }
    
    func retryLoadPopularMovies() {
        view?.hideErrorView()
        loadPopularMovies()
    }
    
    private func loadPopularMovies() {
        if moviesViewModel.isLoading {
            return
        }
        moviesViewModel.start()
        view?.showLoading(message: "Loading...")
        interactor?.makePopularMoviesRequest(page: moviesViewModel.page)
    }
    
    func didSeletMovie(at indexPath: IndexPath) {
        let movie = moviesViewModel.movie(at: indexPath)
        lastSelectedIndexPath = indexPath
        wireFrame?.pushMovieDetailVC(view: view!, movie: movie)
    }
    
    func selectedAllFavMovie() {
        wireFrame?.pushAllFavMoviesVC(view: view!)
    }
    
    func selectedFav(at indexPath: IndexPath) {
        let movie = moviesViewModel.movie(at: indexPath)
        movie.isFav = !movie.isFav
        interactor?.toogleFav(movie: movie)
    }
    
}

extension PopularMoviesPresenter: PopularMoviesOutputInteractorProtocol {
    
    func onPopularMoviesSuccess(response: PopularMoviesResponse) {
        view?.hideLoading()
        _ = response.results.map { $0.isFav = interactor?.isFav(movie: $0) ?? false }
        moviesViewModel.success(objects: response.results)
        if response.page == 1 {
            view?.showPopularMovies(viewModel: moviesViewModel)
        } else {
            let previousCount = moviesViewModel.moviesCount - response.results.count
            let totalCount = moviesViewModel.moviesCount
            let indexPaths: [IndexPath] = (previousCount..<totalCount).map {
                return IndexPath(item: $0, section: 0)
            }
            view?.insertPopularMovies(at: indexPaths)
        }
    }
    
    func onPopularMoviesError(error: APIError) {
        view?.hideLoading()
        moviesViewModel.failed()
        view?.showErrorView(type: .Custom(title: nil, desc: error.description, image: Image.icEmptyState.image, btnAction: "Retry"))
    }
    
}
