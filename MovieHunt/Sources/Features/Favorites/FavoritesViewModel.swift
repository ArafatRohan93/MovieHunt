//
//  FavoritesViewModel.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 26/2/26.
//

import Foundation
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject{
    @Published var favoriteMovies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let repository: FavoritesRepositoryProtocol
    
    init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchFavorites() async{
        guard !isLoading else { return }
        
        self.isLoading = true
        self.errorMessage = nil
        
        do{
            let favs = try await repository.fetchFavorites()
            self.favoriteMovies = favs
            self.isLoading = false
            self.errorMessage = nil
        }catch{
            AppLogger.log("Failed to fetch favorites: \(error)", category: .business)
            self.isLoading = false
            self.errorMessage = "Failed to fetch favorites."
        }
    }
}
