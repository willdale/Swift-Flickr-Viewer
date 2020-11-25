//
//  TagCellHeader.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 25/11/2020.
//

import UIKit

class HomeHeaderCollectionReusableView: UICollectionReusableView, SelfConfiguringCell {
    
    static var reuseIdentifier: String = "tagCellHeader"
    
    let testText : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(testText)
        
        NSLayoutConstraint.activate([
            testText.topAnchor.constraint(equalTo: topAnchor),
            testText.leadingAnchor.constraint(equalTo: leadingAnchor),
            testText.trailingAnchor.constraint(equalTo: trailingAnchor),
            testText.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
