//
//  TabBarHome.swift
//  TabBarHome
//
//  Created by Andres Camilo Lezcano Restrepo on 3/01/25.
//

import UIKit

class TabBarHomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let homeVC = UIViewController()
        let favoritesVC = UIViewController() // Cambiado a UIViewController
        let newsVC = UIViewController() // Cambiado a UIViewController
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper.fill"), tag: 2)

        let viewControllers = [homeVC, favoritesVC, newsVC]
        self.viewControllers = viewControllers
    }
}
