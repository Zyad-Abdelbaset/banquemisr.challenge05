//
//  MovieDetails.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 28/09/2024.
//

import Foundation
// MARK: - MoviesResponse1
//struct MoviesResponse1: Codable {
//    let adult: Bool
//    let backdropPath: String
//    let budget: Int
//    let genres: String
//    let homepage: String
//    let id: Int
//    let originalLanguage, originalTitle, overview: String
//    let popularity: Double
//    let posterPath: String
//    let releaseDate: String
//    let revenue, runtime: Int
//    let status, title: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case budget, genres, homepage, id
//        case imdbID = "imdb_id"
//        case originCountry = "origin_country"
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
//        case posterPath = "poster_path"
//        case productionCompanies = "production_companies"
//        case productionCountries = "production_countries"
//        case releaseDate = "release_date"
//        case revenue, runtime
//        case spokenLanguages = "spoken_languages"
//        case status, title, video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//}
//
//// MARK: - Genre
//struct Genre: Codable {
//    let id: Int
//    let name: String
//}
//
//// MARK: - ProductionCompany
//struct ProductionCompany: Codable {
//    let id: Int
//    let logoPath, name, originCountry: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case logoPath = "logo_path"
//        case name
//        case originCountry = "origin_country"
//    }
//}
//struct ProductionCountry: Codable {
//    let iso3166_1, name: String
//
//    enum CodingKeys: String, CodingKey {
//        case iso3166_1 = "iso_3166_1"
//        case name
//    }
//}
//
