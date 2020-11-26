//
//  HomeCollectionViewCell.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 24/11/2020.
//

import Foundation
 
import UIKit

class HomeCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
   
    static var reuseIdentifier: String = "homeCollectionViewCell"
    
    // MARK: Type Alias
    typealias DataSource            = UICollectionViewDiffableDataSource<Section, PhotoResponse.Photos.Photo>
    typealias DataSourceSnapshot    = NSDiffableDataSourceSnapshot<Section, PhotoResponse.Photos.Photo>
    typealias FooterRegistration    = UICollectionView.SupplementaryRegistration<HomeItemFooterCollectionReusableView>
    
    // MARK: Properties
    private var group: GroupResponse.Group! = nil {
        didSet {
            self.cellTag = self.group.name._content
        }
    }
    private var person: PersonResponse.Person! = nil {
        didSet {
            self.cellTag = self.person.username._content
        }
    }
    private var collectionView  : UICollectionView! = nil
    private var dataSource      : DataSource!
    private var currentSnapshot = DataSourceSnapshot()
    
    private var cellTag     : String?
    private var cellType    : CollectionType?
    
    static let titleElementKind = "footer-element-kind"
    
    func configure(text: String, type: CollectionType) {
        
        self.cellType = type
        self.cellTag = text

        if type == .group {
            getGroup(for: text) { [weak self] (done) in
                if done {
                    self?.getPhotos(for: text, of: type)
                }
            }
            
        } else if type == .person {
            getPerson(for: text) { [weak self] (done) in
                if done {
                    self?.getPhotos(for: text, of: type)
                }
            }
        } else {
            getPhotos(for: text, of: type)
        }
    }

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureCollectionViewLayout()
        configureCollectionViewDataSource()
 
        PhotoLayouts.shadow(layer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Network
extension HomeCollectionViewCell {
    
    private func getGroup(for text: String, completion: @escaping (Bool) -> ()) {
        let groupRequest = GroupRequest(groupID: text)
        groupRequest.fetchGroup { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let group):
                self?.group = group.group
                completion(true)
            }
        }
    }
    private func getPerson(for text: String,  completion: @escaping (Bool) -> ()) {
        let personRequest = PersonRequest(personID: text)
        personRequest.fetchPerson { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let person):
                self?.person = person.person
                completion(true)
            }
        }
    }
    private func getPhotos(for text: String, of type: CollectionType) {
        let photoRequest = PhotoRequest(photoQuery: text, type: type)
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
extension HomeCollectionViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = dataSource.itemIdentifier(for: indexPath) else { return }
        print(photo)
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
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = false
        collectionView.register(HomeItemCollectionViewCell.self, forCellWithReuseIdentifier: HomeItemCollectionViewCell.reuseIdentifier)
        collectionView.register(HomeItemFooterCollectionReusableView.self, forSupplementaryViewOfKind: HomeViewController.titleElementKind, withReuseIdentifier: HomeItemCollectionViewCell.reuseIdentifier)
        addSubview(collectionView)
    }
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, photo) -> HomeItemCollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemCollectionViewCell.reuseIdentifier, for: indexPath) as! HomeItemCollectionViewCell
            cell.configure(with: photo)
            return cell
        })
        
        let supplementaryRegistration =  FooterRegistration(elementKind: "Footer") { [weak self] (supplementaryView, string, indexPath) in
            
            switch self!.cellType {
            case .tag:
                supplementaryView.titileText.text = self!.cellTag
            case .group:
                supplementaryView.titileText.text = self!.cellTag
            case .person:
                supplementaryView.titileText.text = self!.cellTag
            default:
                supplementaryView.titileText.text = self!.cellTag
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
    }
}
