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
    var person : Person?
    
    func configure(with photo: Photo) {
        titleLabel.text = photo.title
        ownerLabelQuery = photo.id
        setupThumbnailImage(photo)
        setupOwnerLabel(photo.owner)
    }
    
    func setupThumbnailImage(_ photo: Photo) {
        let base = "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
        thumbnailImageView.loadImage(using: base)
    }
    func setupOwnerLabel(_ text: String) {
        ownerLabelQuery = text
        fetchUser()
        
    }
    func setupProfileImage() {
        let base = "https://farm\(person!.iconfarm).staticflickr.com/\(person!.iconserver)/buddyicons/\(person!.nsid).jpg"
        profileImageView.loadImage(using: base)
        
    }
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let profileImageView: CustomProfileImageView = {
        let imageView = CustomProfileImageView()
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
        addSubview(profileImageView)
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
            profileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 44),
            profileImageView.heightAnchor.constraint(equalToConstant: 44)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            userLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            userLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            userLabel.heightAnchor.constraint(equalToConstant: 22)
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

// MARK: - Networking
extension PhotoCell {
    private func url() -> String {
        let urlString = "https://www.flickr.com/services/rest/?method=flickr.people.getInfo&api_key=d3a29a4872a88bffc6651c06ad87a04e&user_id=\(ownerLabelQuery)&format=json&nojsoncallback=1"
        return urlString
    }
    
    private func fetchUser(completion: @escaping (Result<PersonResponse, Error>) -> ()) {
        let urlString = url()
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            do {
                let user = try JSONDecoder().decode(PersonResponse.self, from: data!)
                completion(.success(user))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()

    }
    private func fetchUser() {
        fetchUser { (result) in
            switch result {
            case .success(let personResponse):
                self.person = personResponse.person
                DispatchQueue.main.async {
                    self.userLabel.text = personResponse.person.username._content
                    self.setupProfileImage()
                }
                
            case .failure(let error):
                print("Failed to fetch User: \(error.localizedDescription)")
            }
        }
    }
}

