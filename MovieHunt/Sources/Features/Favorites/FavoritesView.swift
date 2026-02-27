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
                        .onTapGesture {
                            onMovieSelected(movie)
                        }
                }
                .listStyle(.inset)
            }
        }
//        .navigationTitle(
//            Text("Favorites")
//        )
        .navigationBarTitleDisplayMode(.inline)
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
            .frame(width: 70, height: 110)
            .cornerRadius(10)

            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(Font.headline)
                Spacer()
                Text(movie.overview)
                    .font(Font.subheadline)
                    .foregroundStyle(Color.gray)
                    .lineLimit(3)
                Spacer()
                HStack(alignment: .center) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(Color.yellow)

                    Text(String(format: "%.1f", movie.voteAverage))
                }
            }
        }
        .padding(4)
    }
}
