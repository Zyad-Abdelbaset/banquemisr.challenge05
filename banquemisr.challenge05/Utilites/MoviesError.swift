//
//  MoviesError.swift
//  banquemisr.challenge05
//
//  Created by zyad Baset on 27/09/2024.
//

import Foundation
enum MovieError: Error, CustomNSError {
    case invalidResponse
    case invalidEndPoint
    case apiError
    case noData
    case serializationError
    case noConnection
    var localizedDescription: String {
        switch self {
        case .invalidResponse: return "Invalid response code"
        case .noData: return "there is No data (Empty data)"
        case .serializationError: return "Failed in decoding data"
        case .invalidEndPoint: return "Not a valid End Point"
        case .apiError: return "Problem in connecting with API"
        case .noConnection: return "the internet connection maybe lost or weak"
        }
    }
    var errorUserInfo: [String: Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}


