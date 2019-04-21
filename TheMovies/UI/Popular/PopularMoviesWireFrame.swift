//
//  PopularMoviesWireFrame.swift
//  Movies
//
//  Created by Yogesh Pareek on 19/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class PopularMoviesWireFrame: PopularMoviesWireFrameProtocol {
    
    func pushMovieDetail(view: PopularMoviesVCProtocol, movie: Movie) {
        if let superVC = view as? UIViewController {
            let vc = AppNavigationCordinator.shared.createMovieDetailModule(movie: movie)
            superVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
