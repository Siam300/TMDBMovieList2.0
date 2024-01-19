//
//  ContentView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 29/12/23.
//

import SwiftUI

struct TopMovieListView: View {
    private let service: MovieServiceProtocol
    @StateObject var viewModel: TopMovieListViewModel<MovieDataService>
    @State private var searchText = ""
    
    init(service: MovieServiceProtocol) {
        self.service = service
        self._viewModel = StateObject(wrappedValue: TopMovieListViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.movies) { (movie: MovieResults) in
                    NavigationLink(value: movie) {
                        HStack(spacing: 12) {
                            MovieImageView(imagePath: movie.posterPath ?? "")
                                .cornerRadius(6)
                                .frame(width: 120, height: 200)
                            
                            VStack(alignment: .leading) {
                                if let rank = movieRanking(movie) {
                                    Text("Rank: \(rank)")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                }
                                
                                Text("\(movie.title)")
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                                
                                Text(String(format: "Average Vote: %.1f/10", movie.voteAverage))
                                    .font(.subheadline)
                                
                                Text("Release Date: \(movie.releaseDate)")
                                    .font(.caption)
                            }
                            .padding(.horizontal, 5)
                            .cornerRadius(10)
                            .foregroundColor(.black)
                            
                        }
                        .onAppear {
                            if movie == viewModel.movies.last {
                                Task { await viewModel.fetchTopRatedMovies() }
                            }
                        }
                        .font(.footnote)
                    }
                    .listRowBackground(Color("movieList"))
                }
            }
            .navigationTitle("Top Rated Movies")
//            .searchable(text: $searchText, prompt: "Search")
            .navigationDestination(for: MovieResults.self, destination: { movie in
                MovieDetailsView(movie: movie)
            })
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
        .task { await viewModel.fetchTopRatedMovies() }
    }
    
    func movieRanking(_ movie: MovieResults) -> String? {
        guard let index = viewModel.movies.firstIndex(of: movie) else {
            return nil
        }
        
        let rank = index + 1
        return "\(rank)"
    }
}

struct TopMovieListView_Previews: PreviewProvider {
    static var previews: some View {
        TopMovieListView(service: MovieServiceProtocol.self as! MovieServiceProtocol)
    }
}
