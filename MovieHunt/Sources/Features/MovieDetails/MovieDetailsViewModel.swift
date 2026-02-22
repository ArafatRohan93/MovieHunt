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

    private let movieID: Int
    private let repository: MovieRepositoryProtocol

    init(movieID: Int, repository: MovieRepositoryProtocol = MovieRepository())
    {
        self.movieID = movieID
        self.repository = repository
    }

    func loadDetails() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        do {
            let fetchedDetails = try await repository.fetchMovieDetail(
                id: movieID
            )
            self.details = fetchedDetails
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

}
