//
//  TagViewController.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 28/11/2020.
//

import UIKit

class TagViewController: UIViewController {
        
    // MARK: Type Alias
    typealias DataSource            = UICollectionViewDiffableDataSource<Section, PhotoResponse.Photos.Photo>
    typealias DataSourceSnapshot    = NSDiffableDataSourceSnapshot<Section, PhotoResponse.Photos.Photo>
    
    // MARK: Properties

    private var collectionView  : UICollectionView! = nil
    private var dataSource      : DataSource!
    private var currentSnapshot = DataSourceSnapshot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tabBarController?.navigationItem.title = "Tags"
        
        configureCollectionViewLayout()
        configureCollectionViewDataSource()
 
        PhotoLayouts.shadow(view.layer)
        
        getPhotos(for: "mountains", of: .tag)
        
    }
}

// MARK: - Network
extension TagViewController {

    private func getPhotos(for text: String, of type: CollectionType) {
        let photoRequest = PhotoRequest(photoQuery: text, type: type, photosPerPage: 100)
        photoRequest.fetchPhotos { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                self?.applySnapshot(photos: response.photos, photoArray: response.photos.photo)
            }
        }
    }
    private func applySnapshot(photos: PhotoResponse.Photos, photoArray: [PhotoResponse.Photos.Photo]) {
        currentSnapshot = DataSourceSnapshot()
        currentSnapshot.appendSections([Section.main])
        currentSnapshot.appendItems(photoArray)
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}

// MARK: - CollectionView
extension TagViewController: UICollectionViewDelegate {

    enum Section {
        case main
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let edgeInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            // 1
            let fullWidthItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                          heightDimension: .fractionalHeight(0.25)))
            fullWidthItem.contentInsets = edgeInsets
                        
            //2
            let twoThirdItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                                                         heightDimension: .fractionalHeight(1.0)))
            twoThirdItem.contentInsets = edgeInsets
            
            let oneThirdItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                         heightDimension: .fractionalHeight(0.5)))
            oneThirdItem.contentInsets = edgeInsets
            
            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                                                                    heightDimension: .fractionalHeight(1.0)),
                                                                 subitem: oneThirdItem, count: 2)
            
            let secondGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                    heightDimension: .fractionalHeight(0.25)),
                                                                 subitems: [twoThirdItem, trailingGroup])
            
            // 3
            let squareItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                                                       heightDimension: .fractionalHeight(1.0)))
            squareItem.contentInsets = edgeInsets
            
            let squareGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                    heightDimension: .fractionalHeight(0.25)),
                                                                 subitem: squareItem, count: 2)
            
            // 4
            
            let twoThirdItemTwo = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                                                         heightDimension: .fractionalHeight(1.0)))
            twoThirdItemTwo.contentInsets = edgeInsets
            
            let oneThirdItemTwo = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                         heightDimension: .fractionalHeight(0.5)))
            oneThirdItemTwo.contentInsets = edgeInsets
            
            let leadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                                                                    heightDimension: .fractionalHeight(1.0)),
                                                                 subitem: oneThirdItemTwo, count: 2)
            
            let thridGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                    heightDimension: .fractionalHeight(0.25)),
                                                                subitems: [leadingGroup, twoThirdItemTwo])
            
            
            // final
            let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                  heightDimension: .fractionalHeight(1.0)),
                                                                 subitems: [fullWidthItem, secondGroup, squareGroup, thridGroup])
            
            let section = NSCollectionLayoutSection(group: nestedGroup)
            
            return section
        }
        return layout
        
    }
    
    private func configureCollectionViewLayout() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = false
        collectionView.register(TagItemCollectionViewCell.self, forCellWithReuseIdentifier: TagItemCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, photo) -> TagItemCollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagItemCollectionViewCell.reuseIdentifier, for: indexPath) as! TagItemCollectionViewCell
            cell.configure(with: photo)
            return cell
        })
    }
}
