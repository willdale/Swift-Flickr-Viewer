//
//  PhotoLayouts.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 26/11/2020.
//

import UIKit

struct PhotoLayouts {
    
    static func shadow(_ layer: CALayer) {
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    static let cellInsets  = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
    
    //                  LayoutOne
    //   +-------------------------------------+
    //   | +-----------------+  +-----------+  |
    //   | |                 |  |           |  |
    //   | |                 |  |           |  |
    //   | |                 |  |     1     |  |
    //   | |                 |  |           |  |
    //   | |                 |  |           |  |
    //   | |                 |  +-----------+  |
    //   | |        0        |                 |
    //   | |                 |  +-----------+  |
    //   | |                 |  |           |  |
    //   | |                 |  |           |  |
    //   | |                 |  |     2     |  |
    //   | |                 |  |           |  |
    //   | |                 |  |           |  |
    //   | +-----------------+  +-----------+  |
    //   +-------------------------------------+
    static func layoutOne() -> NSCollectionLayoutSection {
        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                                    heightDimension: .fractionalHeight(1.0)))
        leadingItem.contentInsets = cellInsets
        
        let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                     heightDimension: .fractionalHeight(1.0)))
        trailingItem.contentInsets = cellInsets
        
        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                                                heightDimension: .fractionalHeight(1.0)),
                                                             subitem: trailingItem, count: 2)
        
        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                heightDimension: .fractionalHeight(0.9)),
                                                             subitems: [leadingItem, trailingGroup])
        
        let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.1))
        let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize,
                                                                             elementKind: HomeCollectionViewCell.titleElementKind,
                                                                             alignment: .bottom)
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.boundarySupplementaryItems = [titleSupplementary]
        return section
    }
    
    //                  LayoutTwo
    //   +---------------------------------------+
    //   |   +-----------+  +-----------------+  |
    //   |   |           |  |                 |  |
    //   |   |           |  |                 |  |
    //   |   |     1     |  |                 |  |
    //   |   |           |  |                 |  |
    //   |   |           |  |                 |  |
    //   |   +-----------+  |                 |  |
    //   |                  |        0        |  |
    //   |   +-----------+  |                 |  |
    //   |   |           |  |                 |  |
    //   |   |           |  |                 |  |
    //   |   |     2     |  |                 |  |
    //   |   |           |  |                 |  |
    //   |   |           |  |                 |  |
    //   |   +-----------+  +-----------------+  |
    //   +---------------------------------------+
    static func layoutTwo() -> NSCollectionLayoutSection {
        let trailingingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                                        heightDimension: .fractionalHeight(1.0)))
        trailingingItem.contentInsets = cellInsets
        
        let leadingingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                       heightDimension: .fractionalHeight(1.0)))
        leadingingItem.contentInsets = cellInsets
        
        let leadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                                                               heightDimension: .fractionalHeight(1.0)),
                                                            subitem: leadingingItem, count: 2)
        
        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                heightDimension: .fractionalHeight(0.9)),
                                                             subitems: [leadingGroup, trailingingItem])
        
        let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.1))
        let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize,
                                                                             elementKind: HomeCollectionViewCell.titleElementKind,
                                                                             alignment: .bottom)
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.boundarySupplementaryItems = [titleSupplementary]
        
        return section
    }
    
    //                  LayoutThree
    //   +---------------------------------------+
    //   |   +------------------------------+    |
    //   |   |                              |    |
    //   |   |                              |    |
    //   |   |               0              |    |
    //   |   |                              |    |
    //   |   |                              |    |
    //   |   +------------------------------+    |
    //   |                                       |
    //   |   +-----------+      +-----------+    |
    //   |   |           |      |           |    |
    //   |   |           |      |           |    |
    //   |   |     1     |      |     2     |    |
    //   |   |           |      |           |    |
    //   |   |           |      |           |    |
    //   |   +-----------+      +-----------+    |
    //   +---------------------------------------+
    static func layoutThree() -> NSCollectionLayoutSection {
        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                    heightDimension: .fractionalHeight(0.5)))
        leadingItem.contentInsets = cellInsets
        
        let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                     heightDimension: .fractionalHeight(1.0)))
        trailingItem.contentInsets = cellInsets
        
        let trailingGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                  heightDimension: .fractionalHeight(0.5)),
                                                               subitem: trailingItem, count: 2)
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                              heightDimension: .fractionalHeight(0.9)),
                                                           subitems: [leadingItem, trailingGroup])
        
        let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.1))
        let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize,
                                                                             elementKind: HomeCollectionViewCell.titleElementKind,
                                                                             alignment: .bottom)
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.boundarySupplementaryItems = [titleSupplementary]
        
        return section
    }
    
    //                  LayoutFour
    //   +---------------------------------------+
    //   |   +-----------+      +-----------+    |
    //   |   |           |      |           |    |
    //   |   |           |      |           |    |
    //   |   |     0     |      |     1     |    |
    //   |   |           |      |           |    |
    //   |   |           |      |           |    |
    //   |   +-----------+      +-----------+    |
    //   |                                       |
    //   |   +------------------------------+    |
    //   |   |                              |    |
    //   |   |                              |    |
    //   |   |               2              |    |
    //   |   |                              |    |
    //   |   |                              |    |
    //   |   +------------------------------+    |
    //   +---------------------------------------+
    static func layoutFour() -> NSCollectionLayoutSection {
        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                    heightDimension: .fractionalHeight(0.5)))
        leadingItem.contentInsets = cellInsets
        
        let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                     heightDimension: .fractionalHeight(1.0)))
        trailingItem.contentInsets = cellInsets
        
        let trailingGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                  heightDimension: .fractionalHeight(0.5)),
                                                               subitem: trailingItem, count: 2)
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                              heightDimension: .fractionalHeight(0.9)),
                                                           subitems: [trailingGroup, leadingItem])
        
        let titleSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.1))
        let titleSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize,
                                                                             elementKind: HomeCollectionViewCell.titleElementKind,
                                                                             alignment: .bottom)
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.boundarySupplementaryItems = [titleSupplementary]
        return section
    }
    
    
    // MARK: - Tags / Groups / People
    static func fullPageLayout() -> NSCollectionLayoutSection {
        let edgeInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        //                       1
        //   +---------------------------------------+
        //   |   +-------------------------------+   |
        //   |   |                               |   |
        //   |   |                               |   |
        //   |   |                               |   |
        //   |   |                               |   |
        //   |   |                               |   |
        //   |   |                               |   |
        //   |   |                               |   |
        //   |   +-------------------------------+   |
        //   |                                       |
        //   +---------------------------------------+
        let fullWidthItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                      heightDimension: .fractionalHeight(0.25)))
        fullWidthItem.contentInsets = edgeInsets
        
        
        //                       2
        //   +----------------------------------------+
        //   |   +--------------+  +--------------+   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   |              |  +--------------+   |
        //   |   |              |  +--------------+   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   +--------------+  +--------------+   |
        //   |                                        |
        //   |                                        |
        //   |                                        |
        //   |                                        |
        //   +----------------------------------------+
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
        
        //                       3
        //   +----------------------------------------+
        //   |   +--------------+  +--------------+   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   +--------------+  |              |   |
        //   |   +--------------+  |              |   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   +--------------+  +--------------+   |
        //   |                                        |
        //   |                                        |
        //   |                                        |
        //   |                                        |
        //   +----------------------------------------+
        let squareItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                                                   heightDimension: .fractionalHeight(1.0)))
        squareItem.contentInsets = edgeInsets
        
        let squareGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                                heightDimension: .fractionalHeight(0.25)),
                                                             subitem: squareItem, count: 2)
        
        //                       4
        //   +----------------------------------------+
        //   |   +--------------+  +--------------+   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   |              |  |              |   |
        //   |   +--------------+  +--------------+   |
        //   |                                        |
        //   |                                        |
        //   |                                        |
        //   |                                        |
        //   +----------------------------------------+
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
}
