//
//  TabBarViewController.swift
//  Swift Flickr Viewer
//
//  Created by Will Dale on 28/11/2020.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        let firstViewController = HomeViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let secondViewController = TagViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Tags", image: UIImage(systemName: "tag"), tag: 1)
        
        let thirdViewController = HomeViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Groups", image: UIImage(systemName: "person.3"), tag: 2)
        
        let fourthViewController = HomeViewController()
        fourthViewController.tabBarItem = UITabBarItem(title: "People", image: UIImage(systemName: "person"), tag: 3)

        let fifthViewController = SearchViewController()
        fifthViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 4)

        let tabBarList = [firstViewController, secondViewController, thirdViewController, fourthViewController, fifthViewController]

        viewControllers = tabBarList

    }

}
