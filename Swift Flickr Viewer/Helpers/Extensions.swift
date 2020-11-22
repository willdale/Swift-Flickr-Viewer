//
//  Extensions.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 21/11/2020.
//

import UIKit

extension UIView {
    func addContraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String : UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(
                        withVisualFormat: format,
                        metrics: nil,
                        views: viewsDictionary))
    }
}
