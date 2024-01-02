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
                ForEach(viewModel.movies) { movie in
                    NavigationLink(destination: Text("Movie Details: \(movie.title)")) {
                        HStack(spacing: 12) {
                            Text("\(movie.title)")
                                .foregroundColor(.gray)
                        }
                        .onAppear {
                            if movie == viewModel.movies.last {
                                Task { viewModel.fetchMoviesWithCompletionHandler() }
                            }
                        }
                        .font(.footnote)
                    }
                }
            }
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
        .task {
            viewModel.fetchMoviesWithCompletionHandler()
        }
    }
}


struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(service: MovieServiceProtocol.self as! MovieServiceProtocol)
    }
}
