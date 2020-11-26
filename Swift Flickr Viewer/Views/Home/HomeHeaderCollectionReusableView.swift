//
//  HomeHeaderCollectionReusableView.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 25/11/2020.
//

import UIKit

class HomeHeaderCollectionReusableView: UICollectionReusableView, SelfConfiguringCell {
    
    static var reuseIdentifier: String = "tagCellHeader"
    
    let headerText : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubview(headerText)
        
        NSLayoutConstraint.activate([
            headerText.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerText.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
