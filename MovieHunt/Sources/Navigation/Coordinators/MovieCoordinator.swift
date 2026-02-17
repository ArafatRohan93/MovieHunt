//
//  MovieCoordinator.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 18/2/26.
//

import SwiftUI
import UIKit

final class MovieCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let listView = Text("Movie List Screen")
        let hostingController = UIHostingController(rootView: listView)
        hostingController.title = "Movies"

        navigationController.pushViewController(
            hostingController,
            animated: false
        )
    }
}
