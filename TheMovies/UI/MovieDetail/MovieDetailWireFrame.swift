//
//  MovieDetailWireFrame.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 21/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class MovieDetailWireFrame: MovieDetailWireFrameProtocol {
    
    func pushMovieCastVC(view: MovieDetailVCProtocol, model: MovieDetailViewModel) {
        if let superVC = view as? UIViewController {
            let vc = AppNavigationCordinator.shared.createMovieDetailModule(movieDetailViewModel: model)
            superVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
