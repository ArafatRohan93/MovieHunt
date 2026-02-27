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
        let favoriteRepository = FavoritesRepository()
        let favoriteViewModel = FavoritesViewModel(repository: favoriteRepository)
        
        let favoriteView = FavoritesView(viewModel: favoriteViewModel){
            [weak self] movie in
            self?.showMovieDetails(for: movie)
        }
        
        let favoriteHostingController = UIHostingController(
            rootView: favoriteView
        )
        favoriteHostingController.title = "Favorites"
        navigationController.pushViewController(
            favoriteHostingController,
            animated: true
        )
    }
    
    func showMovieDetails(for movie: Movie){
        AppLogger.log("FavoriteCoordinator: Opening movie details for \(movie.title)", category: .navigation)
        
        let favoriteRepository = FavoritesRepository()
        let movieRepository = MovieRepository()
        let movieDetailsViewModel = MovieDetailsViewModel(
            movieID: movie.id,
            repository: movieRepository,
            favoritesRepository: favoriteRepository
        )
        
        let movieDView = MovieDetailsView(viewModel: movieDetailsViewModel)
        
        let detailsHostingController = UIHostingController(rootView: movieDView)
        
        navigationController.pushViewController(detailsHostingController, animated: true)
            
    }
}
