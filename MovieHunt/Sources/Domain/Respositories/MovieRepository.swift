//
//  MovieRepository.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 18/2/26.
//

final class MovieRepository: MovieRepositoryProtocol, @unchecked Sendable {
    private let networkService: NetworkServiceProtocol

   nonisolated init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchMovieDetail(id: Int) async throws -> MovieDetails {
        return try await networkService.request(
            MovieEndpoint.movieDetails(id: id)
        )
    }

    func fetchNowPlaying(page: Int) async throws -> [Movie] {
        let response: MovieResponse = try await networkService.request(
            MovieEndpoint.nowPlaying(page: page)
        )

        return response.results
    }

}
