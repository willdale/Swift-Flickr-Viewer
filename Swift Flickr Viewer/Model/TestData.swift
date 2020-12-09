//
//  TestData.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 25/11/2020.
//

import UIKit

// Item
struct SearchType: Hashable {
    let title: String
    let type : CollectionType
    let identifier = UUID()
}
// section
struct SectionType: Hashable {
    let type: CollectionType
    let items: [SearchType]
    let identifier = UUID()
}

struct TestData {
    let data : [SectionType] = [
        SectionType(type: .tag, items: [SearchType(title: "Mountains",          type: CollectionType.tag),
                                        SearchType(title: "Lake",               type: CollectionType.tag),
                                        SearchType(title: "Landscape",          type: CollectionType.tag),
                                        SearchType(title: "Seascape",           type: CollectionType.tag)]),
        SectionType(type: .group, items: [SearchType(title: "16978849@N00",     type: CollectionType.group),
                                          SearchType(title: "13376338@N00",     type: CollectionType.group)]),
        SectionType(type: .person, items: [SearchType(title: "135909126@N06",   type: CollectionType.person),
                                           SearchType(title: "45992839@N04",    type: CollectionType.person)])
    ]
}
