//
//  MovieDetailsViewModel.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 22/2/26.
//

import Combine
import Foundation
internal import os

@MainActor
final class MovieDetailsViewModel: ObservableObject {

    @Published var details: MovieDetails?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isFavorite: Bool = false

    private let movieID: Int
    private let repository: MovieRepositoryProtocol
    private let favoritesRepository: FavoritesRepositoryProtocol

    init(
        movieID: Int,
        repository: MovieRepositoryProtocol,
        favoritesRepository: FavoritesRepositoryProtocol
    ) {
        self.movieID = movieID
        self.repository = repository
        self.favoritesRepository = favoritesRepository
    }

    func loadDetails() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        do {
            let fetchedDetails = try await repository.fetchMovieDetail(
                id: movieID
            )
            let favoriteStatus = try await favoritesRepository.isFavorite(
                movieID: movieID
            )
            self.details = fetchedDetails
            self.isFavorite = favoriteStatus
            isLoading = false
            AppLogger.log(
                "ViewModel: Movie Details Loaded for \(fetchedDetails.title)",
                category: .business
            )

        } catch {
            isLoading = false
            self.errorMessage = "Failed to fetch movie details."
            AppLogger.log(
                "ViewModel Error: \(error.localizedDescription)",
                category: .business,
                level: .error
            )

        }
    }


    func toggleFavorite() async {
        guard
            let movie = self.details.map({
                Movie(
                    id: $0.id,
                    title: $0.title,
                    overview: $0.overview,
                    posterPath: $0.posterPath,
                    releaseDate: $0.releaseDate,
                    voteAverage: $0.voteAverage
                )
            })
        else { return }

        await favoritesRepository.toggleFavorite(movie: movie)
        do {
            self.isFavorite = try await favoritesRepository.isFavorite(
                movieID: movie.id
            )
        } catch {
            AppLogger.log(
                "DetailsViewModel: Failed to check if movie is favorite after toggle: \(error)",
                category: .business,
                level: .error
            )
        }
    }

}
