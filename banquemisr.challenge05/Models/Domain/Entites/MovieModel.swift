//
//  MovieModel.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation

// MARK: - MoviesResponse
struct MoviesResponse: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String,CodingKey {
        case movies = "results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let originalLanguage: String?
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

