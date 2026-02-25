//
//  FavoritesRepositoryProtocol.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 22/2/26.
//

protocol FavoritesRepositoryProtocol: Sendable {
    func isFavorite(movieID: Int) async throws -> Bool
    func toggleFavorite(movie: Movie) async
    func fetchFavorites() async throws -> [Movie]
}
