//
//  UIButton+Ext.swift
//  TheMovies
//
//  Created by Yogesh Pareek on 20/04/19.
//  Copyright © 2019 Yogesh Pareek. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setTitleForAllStates(_ title: String?) {
        setTitle(title, for: .normal)
        setTitle(title, for: .selected)
        setTitle(title, for: .disabled)
        setTitle(title, for: .focused)
        setTitle(title, for: .highlighted)
    }
    
}
