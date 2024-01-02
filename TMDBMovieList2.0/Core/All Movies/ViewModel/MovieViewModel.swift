//
//  MovieViewModel.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 29/12/23.
//

import Foundation

class MovieViewModel<Service: MovieServiceProtocol>: ObservableObject {
    @Published var movies: [MoviesResponse] = []
    @Published var errorMessage: String?
    private let service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func fetchMoviesWithCompletionHandler() {
        service.fetchMoviesWithResult { [weak self] (result: Result<[MoviesResponse], MovieAPIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies 
                case .failure(let error):
                    self?.errorMessage = error.customDescription
                }
            }
        }
    }
}
