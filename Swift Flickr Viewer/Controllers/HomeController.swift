//
//  HomeController.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 25/11/2020.
//

import UIKit

class HomeController {
    
    enum CollectionType: String {
        case tag
        case group
    }
    
    struct Item: Hashable {
        let title: String
        let type : String
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    struct ItemCollection: Hashable {
        let title: String
        let items: [Item]
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    var collections: [ItemCollection] {
        return _collections
    }

    init() {
        generateCollections()
    }
    fileprivate var _collections = [ItemCollection]()
}

extension HomeController {
    func generateCollections() {
        _collections = [
            ItemCollection(title: "Your Tags", items: [Item(title: "Mountains",    type: CollectionType.tag.rawValue),
                                                      Item(title: "Lake",         type: CollectionType.tag.rawValue),
                                                      Item(title: "Landscape",    type: CollectionType.tag.rawValue),
                                                      Item(title: "Seascape",     type: CollectionType.tag.rawValue)]),
            
            ItemCollection(title: "Your Groups", items: [Item(title: "16978849@N00", type: CollectionType.group.rawValue),
                                                        Item(title: "13376338@N00", type: CollectionType.group.rawValue)])
        ]
    }
}
