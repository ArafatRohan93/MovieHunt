//
//  FavoriteRecord.swift
//  MovieHunt
//
//  Created by Arafat Rohan Vivasoft on 22/2/26.
//

import Foundation
import SwiftData

@Model
final class FavoriteRecord {
    @Attribute(.unique) var id: Int
    var title: String
    var posterPath: String?
    var voteAverage: Double
    var addedDate: Date

    init(id: Int, title: String, posterPath: String?, voteAverage: Double) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.addedDate = Date()
    }
}
