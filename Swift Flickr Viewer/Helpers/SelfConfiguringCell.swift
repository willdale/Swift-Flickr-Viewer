//
//  SelfConfiguringCell.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 22/11/2020.
//

import UIKit

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with type: SearchType, coordinator: MainCoordinator)
}

protocol SelfConfiguringPhotoCell {
    static var reuseIdentifier: String { get }
}
