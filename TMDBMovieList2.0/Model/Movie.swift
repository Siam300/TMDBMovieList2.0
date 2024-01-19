//
//  MovieModel.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 29/12/23.
//

import Foundation

// MARK: - Movie
struct Movie: Decodable {
    
    let page: Int
    let results: [MovieResults]
    let totalPages: Int
    let totalResults: Int

    private enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieResults
struct MovieResults: Decodable, Identifiable, Equatable, Hashable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie {
    static var Mock_Movies: [Movie] = [
        .init(page: 1, results: [MovieResults(
            adult: false,
            backdropPath: "/backdrop_path.jpg",
            genreIds: [1, 2, 3],
            id: 123,
            originalLanguage: "en",
            originalTitle: "Mock Movie",
            overview: "This is a mock movie overview.",
            popularity: 45.67,
            posterPath: "/poster_path.jpg",
            releaseDate: "2022-01-19",
            title: "Mock Movie",
            video: false,
            voteAverage: 8.5,
            voteCount: 100
        )], totalPages: 10, totalResults: 10)
    ]
}
