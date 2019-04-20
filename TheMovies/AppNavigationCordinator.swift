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
    
    func createMoviesModule() -> UIViewController {
        let vc = UIStoryboard(name: "Popular", bundle: nil)
            .instantiateViewController(withIdentifier: "PopularMoviesVC") as! PopularMoviesVC
        
        let presenter: PopularMoviesPresenterProtocol & PopularMoviesOutputInteractorProtocol = PopularMoviesPresenter()
        let interactor: PopularMoviesInputInteractorProtocol = PopularMoviesInteractor()
        let wireFrame: PopularMoviesWireFrameProtocol = PopularMoviesWireFrame()
        
        vc.presenter = presenter
        
        presenter.view = vc
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        
        interactor.presenter = presenter
        
        return vc
    }
    
}


