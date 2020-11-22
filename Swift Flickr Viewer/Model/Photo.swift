//
//  Photo.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 21/11/2020.
//

import Foundation

struct Response: Codable, Hashable {
    let photos  : Photos
    let stat    : String
}

struct Photos: Codable, Hashable {
    let photo   : [Photo]
}

struct Photo: Codable, Hashable {
    let id      : String
    let owner   : String
    let secret  : String
    let server  : String
    let title   : String
}
