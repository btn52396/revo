//
//  UIVIewControllerExtension.swift
//  Revo
//
//  Created by Bryan Nguyen on 8/6/20.
//  Copyright © 2020 Bryan Nguyen. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
