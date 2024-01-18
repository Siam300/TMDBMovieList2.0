//
//  MovieViewModel.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 29/12/23.
//

import Foundation

class MovieViewModel<Service: MovieServiceProtocol>: ObservableObject {
    @Published var movies: [TopRatedMovies] = []
    @Published var errorMessage: String?
    private let service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    @MainActor
    func fetchTopRatedMovies() async {
        do {
            let movies = try await service.fetchTopRatedMovies()
            self.movies.append(contentsOf: movies)
        } catch {
            guard let error = error as? MovieAPIError else { return }
            self.errorMessage = error.customDescription
        }
    }
}
