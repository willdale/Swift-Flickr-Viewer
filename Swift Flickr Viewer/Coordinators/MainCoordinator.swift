//
//  MainCoordinator.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 09/12/2020.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationConroller: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationConroller = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        vc.coordinator = self
        navigationConroller.pushViewController(vc, animated: true)
    }
    
    func typeDetailView(with photo: PhotoResponse.Photos.Photo) {
        let vc = TypeDetailViewController()
        vc.coordinator = self
        vc.configure(with: photo)
        navigationConroller.pushViewController(vc, animated: true)
    }
    
}
