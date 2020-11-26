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
    private let homeController  = HomeController()
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
            
            let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.1),
                                                   heightDimension: .fractionalHeight(0.05))
            let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize,
                                                                                 elementKind: HomeViewController.titleElementKind,
                                                                                 alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 22, leading: 12, bottom: 0, trailing: 12)
            section.interGroupSpacing = 8
            section.boundarySupplementaryItems = [titleSupplementary]
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 60
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    // MARK: Config CollectionView
    private func configureCollectionViewLayout() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    // MARK: Config Datasource
    private func configureCollectionViewDataSource() {
        let cellRegistration = CellRegistration { (cell, indexPath, tag) in
            // Populate the cell with our item description.
            cell.configure(text: tag.title, type: CollectionType(rawValue: tag.type)!)
        }
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: HomeController.Item) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        let supplementaryRegistration =  HeaderRegistration(elementKind: "Header") { (supplementaryView, string, indexPath) in
                supplementaryView.titileText.text = "Bob"
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: index)
        }
        
        currentSnapshot = DataSourceSnapshot()
        homeController.collections.forEach {
            let collection = $0
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.items)
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}
