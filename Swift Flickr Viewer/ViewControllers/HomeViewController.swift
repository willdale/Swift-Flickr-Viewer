//
//  HomeViewController.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 24/11/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Type Alias
    typealias CellRegistration      = UICollectionView.CellRegistration<HomeCollectionViewCell, HomeController.Item>
    typealias DataSource            = UICollectionViewDiffableDataSource<HomeController.ItemCollection, HomeController.Item>
    typealias DataSourceSnapshot    = NSDiffableDataSourceSnapshot<HomeController.ItemCollection, HomeController.Item>
    typealias HeaderRegistration    = UICollectionView.SupplementaryRegistration<HomeHeaderCollectionReusableView>
    
    // MARK: Properties
    private let tagsController  = HomeController()
    private var collectionView  : UICollectionView! = nil
    private var dataSource      : DataSource!
    private var currentSnapshot : DataSourceSnapshot! = nil
    
    static let titleElementKind = "header-element-kind"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionViewLayout()
        configureCollectionViewDataSource()
                
        navigationItem.title = "Home"
    }
    
}

// MARK: - CollectionView
extension HomeViewController: UICollectionViewDelegate {
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                   heightDimension: .fractionalWidth(0.9))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)

            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(44))
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize,
                                                                                 elementKind: HomeViewController.titleElementKind,
                                                                                 alignment: .top)
            section.boundarySupplementaryItems = [titleSupplementary]
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private func configureCollectionViewLayout() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
        collectionView.register(HomeHeaderCollectionReusableView.self, forSupplementaryViewOfKind: HomeViewController.titleElementKind, withReuseIdentifier: HomeHeaderCollectionReusableView.reuseIdentifier)
        view.addSubview(collectionView)
    }
    private func configureCollectionViewDataSource() {
        let cellRegistration = CellRegistration { (cell, indexPath, tag) in
            // Populate the cell with our item description.
            cell.configure(text: tag.title, type: HomeController.CollectionType(rawValue: tag.type)!)
        }
        
       dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: HomeController.Item) -> UICollectionViewCell? in
            // Return the cell.
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        let supplementaryRegistration = HeaderRegistration(elementKind: "Header") {(supplementaryView, string, indexPath) in
            if let snapshot = self.currentSnapshot {
                // Populate the view with our section's description.
                let tag = snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.testText.text = tag.title
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        
        currentSnapshot = DataSourceSnapshot()
        tagsController.collections.forEach {
            let collection = $0
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.tags)
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}
