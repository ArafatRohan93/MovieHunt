//
//  MovieDetailsView.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 22/2/26.
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let movie = viewModel.details {
                    AsyncImage(url: movie.backdropURL) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Rectangle().fill(Color.gray.opacity(0.3))
                    }
                    .frame(height: 250)
                    .clipped()

                    VStack(alignment: .leading, spacing: 12) {
                        Text(movie.title)
                            .font(Font.largeTitle)
                            .bold()

                        if let tagline = movie.tagline, !tagline.isEmpty {
                            Text("\"\(tagline)\"")
                                .font(Font.subheadline)
                                .italic()
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal, 8)

                    HStack(spacing: 20) {
                        if let runtime = movie.runtime {
                            Label("\(runtime) min", systemImage: "clock")
                        }

                        Label(
                            String(format: "%.1f", movie.voteAverage),
                            systemImage: "star.fill"
                        )
                        .foregroundColor(.yellow)
                    }
                    .font(.caption)
                    .padding(.horizontal, 8)

                    HStack {
                        ForEach(movie.genres) { genre in
                            Text(genre.name)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(4)
                                .font(.caption2)
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal, 8)

                    Divider()

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Overview")
                            .font(.headline)
                        Text(movie.overview)
                            .font(.body)
                    }
                    .padding(.horizontal, 8)

                } else if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 100)
                } else if let message = viewModel.errorMessage {
                    Text(message)
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
        .navigationBarItems(
            trailing: Button(action: {
                Task { await viewModel.toggleFavorite() }
            }) {
                Image(
                    systemName: viewModel.isFavorite ? "heart.fill" : "heart"
                )
                
            }
            .foregroundStyle(Color(viewModel.isFavorite ? .green : .black))
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Details")
            .task {
                await viewModel.loadDetails()
            }
        )

    }
}
