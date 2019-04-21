//
//  BaseUIViewController.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 20/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {
    
    private var emptyStateView: SNEmptyStateView = SNEmptyStateView()
    private var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUITheme()
        setUI()
    }
    
    internal func setUI() {}
    
    internal func setUITheme() {}
    
    func showLoadingView(msg: String) {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator?.color = UIColor.red
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.startAnimating()
        self.view.addSubview(activityIndicator!)
        self.view.bringSubviewToFront(activityIndicator!)
        
        activityIndicator?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func hideLoadingView() {
        activityIndicator?.removeFromSuperview()
    }
    
    func showError(type: EmptyErrorType, delegate: SNEmptyStateViewDelegate? = nil) {
        emptyStateView
            .delegate(with: delegate)
            .action(btn: type.actionBtn)
            .with(title: type.title, subTitle: type.desc, image: type.image)
            .show()
    }
    
    func hideError() {
        if emptyStateView.superview != nil {
            emptyStateView.removeFromSuperview()
        }
    }
}
