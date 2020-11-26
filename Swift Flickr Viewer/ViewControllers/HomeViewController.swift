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
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
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
            cell.configure(text: tag.title, type: HomeController.CollectionType(rawValue: tag.type)!)
        }
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: HomeController.Item) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
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
