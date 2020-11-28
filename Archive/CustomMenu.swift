//
//  CustomMenu.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 28/11/2020.
//

import UIKit

//let menuBar : MenuBar = {
//   let menu = MenuBar()
//    menu.translatesAutoresizingMaskIntoConstraints = false
//    return menu
//}()
//
//private func setupMenuBar() {
//    view.addSubview(menuBar)
//    NSLayoutConstraint.activate([
//        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//        menuBar.heightAnchor.constraint(equalToConstant: 60)
//    ])
//}
//
//class MenuBar: UIView {
//
//    // MARK: Type Alias
//    typealias DataSource            = UICollectionViewDiffableDataSource<Section, MenuItem>
//    typealias DataSourceSnapshot    = NSDiffableDataSourceSnapshot<Section, MenuItem>
//
//    // MARK: Properties
//    private var menuItems       : [MenuItem] = MenuItems().menuItems
//    private var collectionView  : UICollectionView! = nil
//    private var dataSource      : DataSource!
//    private var currentSnapshot : DataSourceSnapshot! = nil
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        backgroundColor = .systemBackground
//
//        configureCollectionViewLayout()
//        configureCollectionViewDataSource()
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//// MARK: - CollectionView
//extension MenuBar: UICollectionViewDelegate {
//
//    enum Section {
//        case main
//    }
//
//    private func createLayout() -> UICollectionViewLayout {
//
//        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                  heightDimension: .fractionalHeight(1.0))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/5),
//                                                   heightDimension: .fractionalHeight(1.0))
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .continuous
//            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
////            section.interGroupSpacing = 8
//
//            return section
//        }
//
//        let config = UICollectionViewCompositionalLayoutConfiguration()
////        config.interSectionSpacing = 60
//
//        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
//        return layout
//    }
//
//    private func configureCollectionViewLayout() {
//        collectionView = UICollectionView(frame: bounds, collectionViewLayout: createLayout())
//        collectionView.delegate = self
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.backgroundColor = .systemBackground
//        collectionView.alwaysBounceVertical = false
//        collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: MenuItemCell.reuseIdentifier)
//        addSubview(collectionView)
//    }
//    private func configureCollectionViewDataSource() {
//        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> MenuItemCell? in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.reuseIdentifier, for: indexPath) as! MenuItemCell
//            cell.configure(item.itemTitle, item.itemSymbol)
//            return cell
//        })
//
//        currentSnapshot = DataSourceSnapshot()
//        currentSnapshot.appendSections([Section.main])
//        currentSnapshot.appendItems(menuItems)
//        dataSource.apply(currentSnapshot, animatingDifferences: false)
//    }
//}
//
//class MenuItemCell: UICollectionViewCell, SelfConfiguringCell {
//
//    static var reuseIdentifier: String = "menuItemCell"
//
//    var menuItem : MenuItem?
//
//    let menuImage : UIImageView = {
//       let imageView = UIImageView()
//        imageView.tintColor = .systemGray
//        imageView.contentMode = .center
//        return imageView
//    }()
//
//
//    let menuText : UILabel = {
//        let label = UILabel()
//        label.textColor = .systemGray
//        label.textAlignment = .center
//        return label
//    }()
//    func configure(_ text: String, _ image: String) {
//        menuText.text = text
//        menuImage.image = UIImage(systemName: image)
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setupView()
//    }
//
//    private func setupView() {
//        addSubview(menuImage)
//        addSubview(menuText)
//
//        addContraintsWithFormat(format: "H:|[v0]|", views: menuImage)
//        addContraintsWithFormat(format: "H:|[v0]|", views: menuText)
//        addContraintsWithFormat(format: "V:[v0(25)][v1(25)]", views: menuImage, menuText)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
