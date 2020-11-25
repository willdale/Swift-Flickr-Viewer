//
//  PhotoCell.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 21/11/2020.
//

import UIKit

class PhotoCell: UICollectionViewCell, SelfConfiguringCell {
   
    static var reuseIdentifier: String = "photoCell"
    
    var ownerLabelQuery : String = "135909126@N06"
    var person : PersonResponse.Person?
    
    func configure(with photo: Photo) {
        setupThumbnailImage(photo)
    }
    
    func setupThumbnailImage(_ photo: Photo) {
        let base = "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
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
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 300)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
