//
//  FavoritesRepository.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 23/2/26.
//

import Foundation
import SwiftData

final class FavoritesRepository: FavoritesRepositoryProtocol {
    private let container: ModelContainer

    @MainActor
    private var context: ModelContext {
        container.mainContext
    }

    nonisolated init() {
        do {
            self.container = try ModelContainer(for: FavoriteRecord.self)
        } catch {
            fatalError("Failed to initialize SwiftData: \(error)")
        }
    }

    @MainActor
    func isFavorite(movieID: Int) async throws -> Bool {
        let descriptor = FetchDescriptor<FavoriteRecord>(
            predicate: #Predicate { $0.id == movieID }
        )
        let count = (try? context.fetchCount(descriptor)) ?? 0
        return count > 0
    }

    @MainActor
    func toggleFavorite(movie: Movie) async {
        let isFav = (try? await isFavorite(movieID: movie.id)) ?? false

        if isFav {
            let movieID = movie.id
            try? context.delete(
                model: FavoriteRecord.self,
                where: #Predicate { $0.id == movieID }
            )
        } else {
            let record = FavoriteRecord(
                id: movie.id,
                title: movie.title,
                overview: movie.overview,
                posterPath: movie.posterPath,
                voteAverage: movie.voteAverage
            )
            context.insert(record)
        }
        try? context.save()
    }

    @MainActor
    func fetchFavorites() async throws -> [Movie] {
        let descriptor = FetchDescriptor<FavoriteRecord>(sortBy: [
            SortDescriptor(\.addedDate, order: .reverse)
        ])

        do {
            let records = try context.fetch(descriptor)

            return records.map { record in
                Movie(
                    id: record.id,
                    title: record.title,
                    overview: record.overview ?? "",
                    posterPath: record.posterPath,
                    releaseDate: nil,
                    voteAverage: record.voteAverage
                )
            }

        } catch {
            AppLogger.log(
                "Favorite Repository: Failed to fetch favorites: \(error.localizedDescription)",
                category: .storage,
            )
            throw error
        }
    }
}
