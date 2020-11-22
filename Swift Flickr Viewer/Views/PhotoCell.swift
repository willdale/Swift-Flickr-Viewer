//
//  PhotoCell.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 21/11/2020.
//

import UIKit

class PhotoCell: UICollectionViewCell, SelfConfiguringCell {
   
    static var reuseIdentifier: String = "photoCell"

    var photo : Photo?
    
    func configure(with photo: Photo) {
        
        self.photo = photo
        titleLabel.text = photo.title
        userLabel.text = photo.owner
        
        setupThumbnailImage()
    }
    
    func setupThumbnailImage() {
        guard let safePhoto = photo  else { return }
        let base = "https://live.staticflickr.com/\(safePhoto.server)/\(safePhoto.id)_\(safePhoto.secret).jpg"
        thumbnailImageView.loadImage(using: base)
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let titleLabel: UILabel = {
        let labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
    let userLabel: UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.textColor = .systemGray
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        backgroundColor = .white
  
        setupView()
    }
    
    private func setupView() {
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(userLabel)
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            userLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            userLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 2),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 2)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CustomImageView: UIImageView {
    
    var imageUrlString : String?
    
    func loadImage(using urlString: String) {
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }).resume()
    }
}
