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
    
    func configure(with type: SearchType, coordinator: MainCoordinator) {
        titileText.text = type.title
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubview(titileText)
        
        NSLayoutConstraint.activate([
            titileText.centerXAnchor.constraint(equalTo: centerXAnchor),
            titileText.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HomeHeaderCollectionReusableView: UICollectionReusableView, SelfConfiguringCell {
    
    static var reuseIdentifier: String = "homeHeaderCollectionReusableView"
        
    let titileText : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(with type: SearchType, coordinator: MainCoordinator) {
        titileText.text = type.type.rawValue.capitalized
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubview(titileText)
        
        NSLayoutConstraint.activate([
            titileText.centerXAnchor.constraint(equalTo: centerXAnchor),
            titileText.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        PhotoLayouts.shadow(layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
