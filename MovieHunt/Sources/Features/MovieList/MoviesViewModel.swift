//
//  MoviesViewModel.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 18/2/26.
//

import Combine
import Foundation
import OSLog

@MainActor
final class MoviesViewModel: ObservableObject {

    // 1. publish properties which UI components will listen to
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var favorites: Set<Int> = []
    @Published var errorMessage: String?

    // 2. Dependencies
    private let movieRepository: MovieRepositoryProtocol
    private let favoriteRepository: FavoritesRepositoryProtocol

    init(
        movieRepository: MovieRepositoryProtocol,
        favoriteRepository: FavoritesRepositoryProtocol
    ) {
        self.movieRepository = movieRepository
        self.favoriteRepository = favoriteRepository
    }

    // 3. Methods

    func loadMovies() async {
        guard isLoading == false else { return }

        isLoading = true
        errorMessage = nil

        do {
            let fetchedMovies = try await movieRepository.fetchNowPlaying(
                page: 1
            )
            self.movies = fetchedMovies
            isLoading = false
            AppLogger.log(
                "ViewModel: Successfully loaded \(fetchedMovies.count) movies",
                category: .business
            )
        } catch {
            isLoading = false
            self.errorMessage = "Faied to load movies. Please try again"
            AppLogger.log(
                "ViewModel Error: Failed to load movies with error: \(error)",
                category: .business,
                level: OSLogType.error
            )
        }

        await refreshFavorites()

    }

    func refreshFavorites() async {
        let favs = await favoriteRepository.fetchFavorites()
        self.favorites = Set(favs.map { $0.id })
    }
    
    func toggleFavorite(movie: Movie) async{
        await favoriteRepository.toggleFavorite(movie: movie)
        await refreshFavorites()
    }

}
