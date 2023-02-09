//
//  MovTabBarController.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import UIKit

class MovTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = .systemBlue
        viewControllers = [createSearchNC(),createWatchedNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = MoviesViewController()
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createWatchedNC() -> UINavigationController {
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "Watched", image: UIImage(systemName: "heart.fill"), tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }

}
