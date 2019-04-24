//
//  MovieSearchWireFrame.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 24/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class MovieSearchWireFrame: MovieSearchWireFrameProtocol {
    
    func dismiss(view: MovieSearchVCProtocol) {
        if let vc = view as? UIViewController {
            vc.dismiss(animated: true, completion: nil)
        }
    }
}
