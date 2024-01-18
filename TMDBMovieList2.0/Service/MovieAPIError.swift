//
//  MovieApiError.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 29/12/23.
//

import Foundation

enum MovieAPIError: Error {
    case invalidData
    case jsonParsingFaliure
    case requestFailed(description: String)
    case invalidStatusCode(description: Int)
    case unknownError(error: Error)
    case unprocessableEntity(description: String)
    
    var customDescription: String {
        switch self {
        case .invalidData: return "Invalid Data"
        case .jsonParsingFaliure: return "Failed to parse JSON"
        case let .requestFailed(description): return "Request failed: \(description)"
        case let .invalidStatusCode(statusCode): return "Invalid status code \(statusCode)"
        case let .unknownError(error): return "An unknown error occuard \(error.localizedDescription)"
        case let .unprocessableEntity(description):
                return "Unprocessable Entity: \(description)"
        }
    }
}
