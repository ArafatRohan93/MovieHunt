//
//  MovieListView.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 18/2/26.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel: MoviesViewModel

    var onMovieSelected: (Movie) -> Void

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView("Loading Movies")
            } else if let error = viewModel.errorMessage {
                VStack {
                    Text(error)
                        .foregroundStyle(Color.red)
                    Button("Retry") {
                        Task { await viewModel.loadMovies() }
                    }
                }
            } else {
                List(viewModel.movies) { movie in
                    MovieRow(movie: movie)
                        .onTapGesture {
                            onMovieSelected(movie)
                        }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Movies")
        .task {
            await viewModel.loadMovies()
        }
    }

}

struct MovieRow: View {
    let movie: Movie

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: movie.posterUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 80, height: 120)
            .cornerRadius(8)
            .clipped()

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(Font.headline)

                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                    .lineLimit(3)

                Spacer()

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", movie.voteAverage))
                }
            }
        }
        .padding(.vertical, 4)
    }
}
