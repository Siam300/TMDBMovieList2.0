//
//  MovieDataService.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 29/12/23.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovies() async throws -> [MoviesResponse]
}

class MovieDataService: HTTPDataDownloader, MovieServiceProtocol {
    private var page = 0
    
    //MARK: - Async/ Await
    func fetchMovies() async throws -> [MoviesResponse] {
        page += 1

        guard let endpoint = allMoviesURLString else {
            throw MovieAPIError.requestFailed(description: "Invalid API")
        }

        do {
            let movieResponseWrapper = try await fetchData(as: MovieResponseWrapper.self, endpoint: endpoint)
            let movies = movieResponseWrapper.results
            return movies
        } catch {
            throw error
        }
    }
    
    private var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/discover/movie"
        
        return components
    }
    
    var allMoviesURLString: String? {
        var components = baseUrlComponents
        
        components.queryItems = [
            .init(name: "include_adult", value: "false"),
            .init(name: "include_video", value: "false"),
            .init(name: "language", value: "en-US"),
            .init(name: "page", value: "\(page)"),
            .init(name: "sort_by", value: "vote_average.desc"),
            .init(name: "without_genres", value: "99,10755"),
            .init(name: "vote_count.gte", value: "200"),
            .init(name: "api_key", value: "840e2c16b07096959518023fa50e8253")
        ]
        
        return components.url?.absoluteString
    }
}
