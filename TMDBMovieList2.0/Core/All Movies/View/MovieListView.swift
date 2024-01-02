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
    @State private var searchText = ""
    
    init(service: MovieServiceProtocol) {
        self.service = service
        self._viewModel = StateObject(wrappedValue: MovieViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.movies) { (movie: MoviesResponse) in
                    NavigationLink(value: movie) {
                        HStack(spacing: 12) {
                            
                            MovieImageView(imagePath: movie.posterPath ?? "")
                                .cornerRadius(10)
                                .frame(width: 120, height: 200)
                            
                            VStack(alignment: .leading) {
                                Text("\(movie.title)")
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                
                                Text(String(format: "Average Vote: %.1f/10", movie.voteAverage))
                                    .font(.subheadline)
                                
                                Text("Release Date: \(movie.releaseDate)")
                                    .font(.caption)
                            }
                            .padding()
                            .cornerRadius(10)
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
            }
            .navigationTitle("Top Rated Movies")
            .searchable(text: $searchText, prompt: "Search")
            .navigationDestination(for: MoviesResponse.self, destination: { movie in
                MovieDetailsView(movie: movie)
            })
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
