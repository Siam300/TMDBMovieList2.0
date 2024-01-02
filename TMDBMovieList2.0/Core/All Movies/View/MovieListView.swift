//
//  ContentView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 29/12/23.
//

import SwiftUI

struct MovieListView: View {
    private let service: MovieServiceProtocol
    @StateObject var viewModel: MovieViewModel<MovieDataService>
    
    init(service: MovieServiceProtocol) {
        self.service = service
        self._viewModel = StateObject(wrappedValue: MovieViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.movies) { (movie: MoviesResponse) in
                    HStack(spacing: 12) {
                        Text("\(movie.title)")
                            .foregroundColor(.black)
                    }
                    .onAppear {
                        if movie == viewModel.movies.last {
                            Task { await viewModel.fetchMovies() }
                        }
                    }
                    .font(.footnote)
                }
            }
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(service: MovieServiceProtocol.self as! MovieServiceProtocol)
    }
}