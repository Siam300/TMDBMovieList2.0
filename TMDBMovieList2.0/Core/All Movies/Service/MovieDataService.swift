//
//  MovieDataService.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 29/12/23.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMoviesWithResult(completion: @escaping (Result<[Movie], MovieAPIError>) -> Void)
}

class MovieDataService: HTTPDataDownloader, MovieServiceProtocol {
    func fetchMoviesWithResult() async throws -> [Movie] {
        page += 1
        
        guard let endpoint = allMoviesURLString else {
            throw MovieAPIError.requestFailed(description: "Invalid API")
        }
        return try await fetchData(as: [Movie].self, endpoint: endpoint)
    }
    
    private var page = 0
    
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

extension MovieDataService {
    func fetchMoviesWithResult(completion: @escaping (Result<[Movie], MovieAPIError>) -> Void) {
        guard let url = URL(string: allMoviesURLString ?? "") else {
            completion(.failure(.requestFailed(description: "Invalid URL")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request failed")))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(description: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                completion(.success(movies))
            } catch {
                print("Debug: Failed to decode with error: \(error)")
                completion(.failure(.jsonParsingFaliure))
            }
        }.resume()
    }
}
