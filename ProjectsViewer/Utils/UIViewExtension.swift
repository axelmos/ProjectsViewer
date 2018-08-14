//
//  UIViewExtension.swift
//  ProjectsViewer
//
//  Created by Mosiejko Axel (Producto Y Tecnologia) on 14/08/2018.
//  Copyright © 2018 Axel Mosiejko. All rights reserved.
//

import UIKit

extension UIView {
    
    func shadowView() {
        layer.borderWidth = 0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.22).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
    }
    
}
