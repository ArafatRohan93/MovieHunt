//
//  FavoriteCoordinator.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 18/2/26.
//

import SwiftUI
import UIKit

final class FavoriteCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let favoriteView = Text("Favorite View")
        let favoriteHostingController = UIHostingController(
            rootView: favoriteView
        )
        favoriteHostingController.title = "Favorites"
        navigationController.pushViewController(
            favoriteHostingController,
            animated: true
        )
    }
}
