//
//  ItemDetailViewController.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 27/11/2020.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    // MARK: Type Alias
    typealias DataSource            = UICollectionViewDiffableDataSource<Section, PhotoResponse.Photos.Photo>
    typealias DataSourceSnapshot    = NSDiffableDataSourceSnapshot<Section, PhotoResponse.Photos.Photo>
    typealias FooterRegistration    = UICollectionView.SupplementaryRegistration<HomeItemFooterCollectionReusableView>
    
    // MARK: Properties
    var item : CollectionType?
    var itemString : String? {
        didSet {
            
        }
    }
    
    private var collectionView  : UICollectionView! = nil
    private var dataSource      : DataSource!
    private var currentSnapshot = DataSourceSnapshot()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch item {
        case .group:
            getPhotos(for: itemString!, of: .group)
        case .person:
            view.backgroundColor = .green
        default:
            view.backgroundColor = .blue
        }

        navigationItem.title = "Detail"
    }
    
    private func getPhotos(for text: String, of type: CollectionType) {
        let photoRequest = PhotoRequest(photoQuery: text, type: type, photosPerPage: 3)
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
extension ItemDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    enum Section {
        case main
    }
    
    private func createLayout() -> UICollectionViewLayout {

        let layout = UICollectionViewCompositionalLayout {(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let layoutStyle = Int.random(in: 0..<4)
            var section: NSCollectionLayoutSection
            
            switch layoutStyle {
            case 0:
                section = PhotoLayouts.layoutOne()
            case 1:
                section = PhotoLayouts.layoutTwo()
            case 2:
                section = PhotoLayouts.layoutThree()
            default:
                section = PhotoLayouts.layoutFour()
            }
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
        collectionView.register(HomeItemCollectionViewCell.self, forCellWithReuseIdentifier: HomeItemCollectionViewCell.reuseIdentifier)
        collectionView.register(HomeItemFooterCollectionReusableView.self, forSupplementaryViewOfKind: HomeViewController.titleElementKind, withReuseIdentifier: HomeItemCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, photo) -> HomeItemCollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemCollectionViewCell.reuseIdentifier, for: indexPath) as! HomeItemCollectionViewCell
            cell.configure(with: photo)
            return cell
        })
        
        let supplementaryRegistration =  FooterRegistration(elementKind: "Footer") { (supplementaryView, string, indexPath) in

        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
    }
}
