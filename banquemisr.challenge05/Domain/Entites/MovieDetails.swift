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
    let genres: [Genre] //-
    let id: Int //-
    let originalLanguage, overview: String //-
    let releaseDate: String //-
    let runtime: Int //-
    let status, title: String //-

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres,id
        case originalLanguage = "original_language"
        case overview
        case releaseDate = "release_date"
        case runtime
        case status, title
    }
}
// MARK: - Genre
struct Genre: Codable {
    let name: String
}
