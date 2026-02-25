//
//  FavoritesView.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 26/2/26.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    var onMovieSelected: (Movie) -> Void

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.errorMessage != nil {
                Text(viewModel.errorMessage!)
                    .foregroundColor(.red)
                Button("Retry") {
                    Task {
                        await viewModel.fetchFavorites()
                    }
                }
            } else if viewModel.favoriteMovies.isEmpty {
                Text("No movies in favorites")
            } else {
                List(viewModel.favoriteMovies) { movie in
                    FavoriteListItem(movie: movie)
                }
            }
        }
        .navigationTitle(
            Text("Favoritessss")
        )
        .task {
            await viewModel.fetchFavorites()
        }
    }
}

struct FavoriteListItem: View {
    let movie: Movie

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: movie.posterUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.25)
            }
            .frame(width: 100, height: 150)

            Text(movie.title)

        }
    }
}
