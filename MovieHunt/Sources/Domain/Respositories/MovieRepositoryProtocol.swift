//
//  MovieRepositoryProtocol.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 18/2/26.
//

protocol MovieRepositoryProtocol: Sendable {
    func fetchNowPlaying(page: Int) async throws -> [Movie]
    func fetchMovieDetail(id: Int) async throws -> MovieDetails
}
