//
//  HomeCollectionViewCell.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 24/11/2020.
//

import Foundation
 
import UIKit

class HomeCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
   
    static var reuseIdentifier: String = "tagCell"
    
    // MARK: Type Alias
    typealias DataSource            = UICollectionViewDiffableDataSource<Section, Photo>
    typealias DataSourceSnapshot    = NSDiffableDataSourceSnapshot<Section, Photo>
    typealias CollectionType        = HomeController.CollectionType
    
    // MARK: Properties
    private var collectionView  : UICollectionView! = nil
    private var datasource      : DataSource!
    private var snapshot        = DataSourceSnapshot()

    private var cellTag : String?
    private var cellType : CollectionType?
    
    func configure(text: String, type: CollectionType) {
        self.cellTag = text
        self.cellType = type
        
        fetchPhotos()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureCollectionViewLayout()
        configureCollectionViewDataSource()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CollectionView
extension HomeCollectionViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = datasource.itemIdentifier(for: indexPath) else { return }
        print(photo)
    }
    
    enum Section {
        case main
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                                        heightDimension: .fractionalHeight(1.0)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                         heightDimension: .fractionalHeight(1.0)))
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                                                      heightDimension: .fractionalHeight(1)),
                                                                 subitem: trailingItem, count: 2)
            
            let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                    heightDimension: .fractionalHeight(1.0)),
                                                                 subitems: [leadingItem, trailingGroup])
            let section = NSCollectionLayoutSection(group: nestedGroup)
            return section
            
        }
        return layout
    }
    
    private func configureCollectionViewLayout() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = false
        collectionView.register(HomeItemCollectionViewCell.self, forCellWithReuseIdentifier: HomeItemCollectionViewCell.reuseIdentifier)
        
        
        addSubview(collectionView)
    }
    private func configureCollectionViewDataSource() {
        datasource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, photo) -> HomeItemCollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemCollectionViewCell.reuseIdentifier, for: indexPath) as! HomeItemCollectionViewCell
            cell.configure(with: photo)
            return cell
        })
    }
}

// MARK: - Networking
extension HomeCollectionViewCell {
    private func url() -> String {
        let base = "https://www.flickr.com/services/rest/"
        let method = "?method=flickr.photos.search"
        let key = "&api_key=\(API.key)"
        var search = ""
        if cellType == .tag {
            search = "&tags=\(cellTag!)"
        } else if cellType == .group {
            search = "&group_id=\(cellTag!)"
        }
        
        let perPage = "&per_page=3"
        let format = "&format=json&nojsoncallback=1"
        let url = base+method+key+search+perPage+format
        return url
    }
    private func fetchPhotos(completion: @escaping (Result<Response, Error>) -> ()) {
        let urlString = url()
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            do {
                let photos = try JSONDecoder().decode(Response.self, from: data!)
                completion(.success(photos))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()

    }
    private func fetchPhotos() {
        fetchPhotos { (result) in
            switch result {
            case .success(let response):
                self.applySnapshot(photos: response.photos.photo)
            case .failure(let error):
                print("Failed to fetch photos: \(error.localizedDescription)")
            }
        }
    }
    
    private func applySnapshot(photos: [Photo]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(photos)
        datasource.apply(snapshot, animatingDifferences: false)
    }
}


