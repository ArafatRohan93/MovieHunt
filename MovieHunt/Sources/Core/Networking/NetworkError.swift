//
//  NetworkError.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 17/2/26.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case unauthorized
    case forbidden
    case notFound
    case serverError(Int)
    case decodingError
    case unknown(Error)

    var description: String {
        switch self {
        case .invalidUrl: return "The URL is invalid"
        case .invalidResponse: return "The response is invalid"
        case .decodingError: return "Failed to decode the response"
        case .unauthorized: return "You are not authorized to access this API"
        case .forbidden: return "You are forbidded to access this API"
        case .notFound: return "The resource you are looking for is not found"
        case .serverError(let code): return "Server Error with code: \(code)"
        case .unknown(let error): return error.localizedDescription
        }
    }
}
