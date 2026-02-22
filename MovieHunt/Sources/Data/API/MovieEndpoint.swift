//
//  MovieEndpoint.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 18/2/26.
//

enum MovieEndpoint: APIEndpoint {
    case nowPlaying(page: Int)
    case movieDetails(id: Int)

    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        case .movieDetails(let id):
            return "/movie/\(id)"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var queryParameters: [String: Any]? {
        let apiKey: String = "0b210be43375ae8c68f73fdc18b35180"

        switch self {
        case .nowPlaying(let page):
            return [
                "api_key": apiKey,
                "page": page,
            ]
        case .movieDetails(let id):
            return [
                "api_key": apiKey
            ]
        }
    }
}
