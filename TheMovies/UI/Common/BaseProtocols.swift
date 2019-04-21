//
//  BaseProtocols.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 20/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

protocol BaseView: class {
    func showErrorView(type: EmptyErrorType)
    func hideErrorView()
    func showErrorAlert(type: EmptyErrorType)
    func showErrorAlert(msg: String)
    
    func showLoading(message: String)
    func hideLoading()
    
    func showAlertSheet(title: String?, msg: String?, actions: [UIAlertAction])
    func showAlert(title: String?, msg: String?, actions: [UIAlertAction])
}

extension BaseView where Self: BaseUIViewController {
    
    func showErrorView(type: EmptyErrorType) {
        self.showError(type: type)
    }
    
    func hideErrorView() {
        self.hideError()
    }
    
    func showErrorAlert(msg: String) {
        self.presentOkAlert(message: msg)
    }
    
    func showErrorAlert(type: EmptyErrorType) {
        self.presentOkAlert(title: type.title ?? "", message: type.desc ?? "")
    }
    
    func showLoading(message: String) {
        self.showLoadingView(msg: message)
    }
    
    func hideLoading() {
        self.hideLoadingView()
    }
    
    func showAlertSheet(title: String?, msg: String?, actions: [UIAlertAction]) {
        self.presentAlert(title: title, message: msg, preferredStyle: .actionSheet, actionBtns: actions, dismissOnTap: false)
    }
    
    func showAlert(title: String?, msg: String?, actions: [UIAlertAction]) {
        self.presentAlert(title: title, message: msg, preferredStyle: .alert, actionBtns: actions, dismissOnTap: false)
    }
    
}

@objc protocol BasePresenter: class {
    func viewDidLoad()
    func viewWillAppear()
    @objc optional func viewWillDisapper()
}
