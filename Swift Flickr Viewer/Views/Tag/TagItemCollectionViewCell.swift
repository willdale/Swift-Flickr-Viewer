//
//  TagCollectionViewCell.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 28/11/2020.
//

import UIKit

class TagItemCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "tagItemCell"
    
    var ownerLabelQuery : String = "135909126@N06"
    var person : PersonResponse.Person?
    
    func configure(with photo: PhotoResponse.Photos.Photo) {
        let base = "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_n.jpg"
        thumbnailImageView.loadImage(using: base)
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        backgroundColor = .white
  
        setupView()
    }
    
    private func setupView() {
        addSubview(thumbnailImageView)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
