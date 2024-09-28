//
//  MovieDetails.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 28/09/2024.
//

import Foundation
// MARK: - MoviesResponse1
struct MovieDetailsEntity: Codable {
    let adult: Bool //-
    let backdropPath: String //-
    let budget: Int //-
    let genres: String //-
    let id: Int //-
    let originalLanguage, overview: String //-
    let popularity: Double //-
    let releaseDate: String //-
    let runtime: Int //-
    let status, title: String //-
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, id
        case originalLanguage = "original_language"
        case overview, popularity
        case releaseDate = "release_date"
        case runtime
        case status, title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
