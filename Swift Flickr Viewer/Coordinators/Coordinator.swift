//
//  Coordinator.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 09/12/2020.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationConroller: UINavigationController { get set }
    func start()
}
