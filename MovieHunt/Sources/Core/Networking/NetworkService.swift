//
//  NetworkService.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 17/2/26.
//

import Foundation
internal import os

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T>(_ endpoint: any APIEndpoint) async throws -> T
    where T: Decodable {
        let urlRequest = try endpoint.asURLRequest()

        // 1. log the request
        AppLogger.log(
            "Request: \(urlRequest.httpMethod ?? "") \(urlRequest.url?.absoluteString ?? "")",
            category: .networking
        )

        do {
            // 2. perform the network call
            let (data, response) = try await session.data(for: urlRequest)

            // 3. validate response
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            // 4. log the response status
            AppLogger.log(
                "Response: \(httpResponse.statusCode) from \(urlRequest.url?.absoluteString ?? "")",
                category: .networking
            )

            // 5. handle status codes
            switch httpResponse.statusCode {
            case 200...299:
                // 6. decode the data
                do {
                    let decodedData = try JSONDecoder().decode(
                        T.self,
                        from: data
                    )
                    return decodedData
                } catch {
                    AppLogger.log(
                        "Decoding Error: \(error.localizedDescription)",
                        category: .networking,
                        level: .error
                    )
                    throw NetworkError.decodingError
                }

            case 401: throw NetworkError.unauthorized
            case 403: throw NetworkError.forbidden
            case 404: throw NetworkError.notFound
            default:
                throw NetworkError.serverError(httpResponse.statusCode)
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            AppLogger.log(
                "Network Error: \(error.localizedDescription)",
                category: .networking,
                level: .error
            )
            throw NetworkError.unknown(error)
        }

    }
}
