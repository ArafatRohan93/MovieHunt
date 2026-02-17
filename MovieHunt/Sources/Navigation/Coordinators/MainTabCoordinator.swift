//
//  MainTabCoordinator.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 17/2/26.
//

import UIKit

final class MainTabCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    private let tabBarCotroller: UITabBarController

    init(tabBarCotroller: UITabBarController = UITabBarController()) {
        self.tabBarCotroller = tabBarCotroller
    }

    func start() {
        // 1. prepare the tabs
        let listNavigator = UINavigationController()
        let favNavigation = UINavigationController()

        // 2. set the tab bar items
        listNavigator.tabBarItem = UITabBarItem(
            title: "Movies",
            image: UIImage(systemName: "film"),
            tag: 0
        )
        favNavigation.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart"),
            tag: 1
        )

        // 3. set colors (optional)
        tabBarCotroller.tabBar.tintColor = .systemBlue

        // 4. attach tabs to the controller
        tabBarCotroller.viewControllers = [listNavigator, favNavigation]

        // 5. start child coordinators
        let movieCoordinator = MovieCoordinator(navigationController: listNavigator)
        addChild(movieCoordinator)
        movieCoordinator.start()
        
        let favoriteCoordinator = FavoriteCoordinator(navigationController: favNavigation)
        addChild(favoriteCoordinator)
        favoriteCoordinator.start()
    }

    func getTabBarController() -> UITabBarController {
        return tabBarCotroller
    }
}
