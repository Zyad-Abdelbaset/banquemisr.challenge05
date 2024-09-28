//
//  MovieModel.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation

// MARK: - MoviesResponse
struct MoviesResponse: Codable {
    let movies: [MoviesList]
    
    enum CodingKeys: String,CodingKey {
        case movies = "results"
    }
}

// MARK: - Result
struct MoviesList: Codable {
    let id: Int
    let posterPath, releaseDate, title: String

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

