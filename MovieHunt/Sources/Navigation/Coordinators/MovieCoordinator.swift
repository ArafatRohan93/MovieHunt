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

        // 1. Create dependencies
        let movieRepository = MovieRepository()
        let viewModel = MoviesViewModel(movieRepository: movieRepository)

        // 2. Create the view with a selection callback
        let listView = MovieListView(viewModel: viewModel) {
            [weak self] movie in
            self?.showMovieDetails(for: movie)
        }

        // 3. Hosting it in UI Kit

        let hostingController = UIHostingController(rootView: listView)
        hostingController.title = "Movies"

        navigationController.pushViewController(
            hostingController,
            animated: false
        )
    }

    func showMovieDetails(for movie: Movie) {
        AppLogger.log(
            "Navigating to details for: \(movie.title)",
            category: .navigation
        )
        
        let viewModel = MovieDetailsViewModel(movieID: movie.id)
        
        let view = MovieDetailsView(viewModel: viewModel)
        
        let hostingController = UIHostingController(rootView: view)
        
        navigationController.pushViewController(hostingController, animated: false)
        
    }
}
