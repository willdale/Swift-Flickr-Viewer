//
//  TypeDetailViewController.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 09/12/2020.
//

import UIKit

class TypeDetailViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    
    var ownerLabelQuery : String = "135909126@N06"
    var person : PersonResponse.Person?
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configure(with photo: PhotoResponse.Photos.Photo) {
        let base = "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
        thumbnailImageView.loadImage(using: base)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    private func setupView() {
        view.addSubview(thumbnailImageView)
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: view.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
