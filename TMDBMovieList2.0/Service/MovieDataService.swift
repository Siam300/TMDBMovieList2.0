//
//  MovieDataService.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 29/12/23.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchTopRatedMovies() async throws -> [MovieResults]
}

class MovieDataService: HTTPDataDownloader, MovieServiceProtocol {
    private var page = 0
    
    //MARK: - Async/ Await
    func fetchTopRatedMovies() async throws -> [MovieResults] {
        page += 1
        
        guard let endpoint = topRatedMoviesURLString else {
            throw MovieAPIError.requestFailed(description: "Invalid API")
        }

        do {
            let Movie = try await fetchData(as: Movie.self, endpoint: endpoint)
            let movies = Movie.results
            return movies
        } catch {
            throw error
        }
    }
    
    func fetchPopularMovies() async throws {
        
    }
    
    
    
    //MARK: - URL session
    private var baseUrlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/discover/movie"
        
        return components
    }
    
    var topRatedMoviesURLString: String? {
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
    
    var popularMoviesURLString: String? {
        var components = baseUrlComponents
        
        components.queryItems = [
            .init(name: "include_adult", value: "false"),
            .init(name: "include_video", value: "false"),
            .init(name: "language", value: "en-US"),
            .init(name: "page", value: "\(page)"),
            .init(name: "sort_by", value: "popularity.desc"),
            .init(name: "api_key", value: "840e2c16b07096959518023fa50e8253")
        ]
        
        return components.url?.absoluteString
    }
}
