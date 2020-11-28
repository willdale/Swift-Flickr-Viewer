//
//  MenuBar.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 28/11/2020.
//

import UIKit



struct MenuItem: Hashable {
    let itemTitle : String
    let itemSymbol : String
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

struct MenuItems {
    
    let menuItems : [MenuItem] = [
        MenuItem(itemTitle: "Home", itemSymbol: "house"),
        MenuItem(itemTitle: "Tags", itemSymbol: "tag"),
        MenuItem(itemTitle: "Groups", itemSymbol: "person.3"),
        MenuItem(itemTitle: "People", itemSymbol: "person"),
        MenuItem(itemTitle: "Search", itemSymbol: "magnifyingglass")
    ]
}
