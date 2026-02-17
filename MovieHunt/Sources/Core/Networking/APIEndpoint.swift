//
//  APIEndpoint.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 17/2/26.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol APIEndpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: Any]? { get }
    var body: Data? { get }
}

extension APIEndpoint {
    var baseUrl: String { return "https://api.themoviedb.org/3" }
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    var queryParameters: [String: Any]? { return nil }
    var body: Data? { return nil }

    func asURLRequest() throws -> URLRequest {
        guard var components = URLComponents(string: baseUrl + path) else {
            throw NetworkError.invalidUrl
        }

        if let queryParameters = queryParameters {
            components.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }

        guard let url = components.url else {
            throw NetworkError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body

        return request
    }
}
