//
//  AppNavigationCordinator.swift
//  Movies
//
//  Created by Yogesh Pareek on 19/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class AppNavigationCordinator {
    
    static let shared: AppNavigationCordinator = AppNavigationCordinator()
    
    private init() {}
    
    func createPopularMoviesModule() -> UIViewController {
        let vc = UIStoryboard(name: "Popular", bundle: nil)
            .instantiateViewController(withIdentifier: "PopularMoviesVC") as! PopularMoviesVC
        
        let presenter: PopularMoviesPresenterProtocol & PopularMoviesOutputInteractorProtocol = PopularMoviesPresenter()
        let favManager = MovieFavManager.shared
        let interactor: PopularMoviesInputInteractorProtocol = PopularMoviesInteractor(manager: favManager)
        let wireFrame: PopularMoviesWireFrameProtocol = PopularMoviesWireFrame()
        
        vc.presenter = presenter
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        
        return vc
    }
    
    func createMovieDetailModule(movie: Movie) -> UIViewController {
        let vc = UIStoryboard(name: "MovieDetail", bundle: nil)
            .instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        
        let presenter: MovieDetailPresenterProtocol & MovieDetailOutputInteractorProtocol = MovieDetailPresenter(movie: movie)
        let favManager = MovieFavManager.shared
        let interactor: MovieDetailInputInteractorProtocol = MovieDetailInteractor(manager: favManager)
        let wireFrame: MovieDetailWireFrameProtocol = MovieDetailWireFrame()
        
        vc.presenter = presenter
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        
        return vc
    }
    
    func createMovieDetailModule(movieDetailViewModel: MovieDetailViewModel) -> UIViewController {
        let vc = MovieCastVC()
        vc.movieViewModel = movieDetailViewModel
        return vc
    }
    
    func createAllFavMoviesModule() -> UIViewController {
        let vc = FavMovieVC()
        return vc
    }
    
}


