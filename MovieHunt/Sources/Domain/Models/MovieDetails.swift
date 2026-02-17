//
//  MovieDetails.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 17/2/26.
//

import Foundation

struct MovieDetails: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let runtime: Int?
    let genres: [Genre]
    let tagline: String?

    struct Genre: Codable, Identifiable {
        let id: Int
        let name: String
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case runtime
        case genres
        case tagline
    }

    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }

        return URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)")
    }

}
