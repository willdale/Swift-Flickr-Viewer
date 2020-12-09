//
//  MainTabBarController.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 28/11/2020.
//

import UIKit

class MainTabBarController: UITabBarController {

    let main = MainCoordinator(navigationController: UINavigationController())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        main.start()
        viewControllers = [main.navigationConroller]

    }

}
