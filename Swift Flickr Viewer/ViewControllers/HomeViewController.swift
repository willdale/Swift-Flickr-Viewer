//
//  HomeViewController.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 24/11/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    // MARK: Type Alias
    typealias CellRegistration      = UICollectionView.CellRegistration<HomeCollectionViewCell, SearchType>
    typealias DataSource            = UICollectionViewDiffableDataSource<SectionType, SearchType>
    typealias DataSourceSnapshot    = NSDiffableDataSourceSnapshot<SectionType, SearchType>
    typealias HeaderRegistration    = UICollectionView.SupplementaryRegistration<HomeHeaderCollectionReusableView>
    
    // MARK: Properties
    private let testData        = TestData().data
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
            let itemSize    = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item        = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize   = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .fractionalWidth(1.0))
            let group       = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let titleSupplementary = self.createSectionHeader()
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets               = NSDirectionalEdgeInsets(top: 22, leading: 12, bottom: 0, trailing: 12)
            section.interGroupSpacing           = 8
            section.boundarySupplementaryItems  = [titleSupplementary]
            
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
        collectionView.register(HomeHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeViewController.titleElementKind)
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        view.addSubview(collectionView)
    }
    
    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with app: SearchType, for indexPath: IndexPath) -> T {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError("Unable to dequeue \(cellType)")
            }

        cell.configure(with: app, coordinator: coordinator!)
            return cell
        }
    
    
    // MARK: Config Datasource
    private func configureCollectionViewDataSource() {
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, type) in
            switch self.testData[indexPath.section].type {
            default:
                return self.configure(HomeCollectionViewCell.self, with: type, for: indexPath)
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeViewController.titleElementKind, for: indexPath) as? HomeHeaderCollectionReusableView else {
                return nil
            }

            guard let firstApp = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: firstApp) else { return nil }

            sectionHeader.titileText.text = section.type.rawValue.capitalized
            return sectionHeader
        }
        
        currentSnapshot = DataSourceSnapshot()
        testData.forEach {
            let collection = $0
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.items)
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
            let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.1), heightDimension: .fractionalHeight(0.05))
            let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            return layoutSectionHeader
        }
}
