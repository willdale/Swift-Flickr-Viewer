//
//  SelfConfiguringCell.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 22/11/2020.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
}
