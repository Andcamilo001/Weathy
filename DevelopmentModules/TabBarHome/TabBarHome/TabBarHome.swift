//
//  TabBarHome.swift
//  TabBarHome
//
//  Created by Andres Camilo Lezcano Restrepo on 3/01/25.
//

import UIKit
import Home
import Favorites

public class TabBarHomeViewController: UITabBarController, UITabBarControllerDelegate {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        self.delegate = self
    }

    private func setupTabBar() {
        let homeVC = SearchRouter.createModule()
        let favoritesVC = FavoritesRouter.createModule()
        let newsVC = UIViewController()
        let logoutVC = LogoutSesionViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper.fill"), tag: 2)
        logoutVC.tabBarItem = UITabBarItem(title: "Logout", image: UIImage(systemName: "person.circle.fill"), tag: 3)

        let viewControllers = [homeVC, favoritesVC, newsVC, logoutVC]
        self.viewControllers = viewControllers
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let favoritesVC = viewController as? FavoritesViewController {
            favoritesVC.viewDidLoad()
        }
    }
}
