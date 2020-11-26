//
//  HomeItemFooterCollectionReusableView.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 26/11/2020.
//

import UIKit

class HomeItemFooterCollectionReusableView: UICollectionReusableView, SelfConfiguringCell {
    
    static var reuseIdentifier: String = "homeItemFooter"
    
    let titileText : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubview(titileText)
        
        NSLayoutConstraint.activate([
//            testText.topAnchor.constraint(equalTo: topAnchor),
//            testText.leadingAnchor.constraint(equalTo: leadingAnchor),
//            testText.trailingAnchor.constraint(equalTo: trailingAnchor),
//            testText.heightAnchor.constraint(equalToConstant: 60)
            titileText.centerXAnchor.constraint(equalTo: centerXAnchor),
            titileText.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
