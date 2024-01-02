//
//  MovieDetailsView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 31/12/23.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie: MoviesResponse
    
    var body: some View {
        VStack {
            Text("\(movie.title)")
                .foregroundColor(.black)
            MovieImageView(imagePath: movie.backdropPath ?? "")
        }
    }
}

//#Preview {
//    MovieDetailsView()
//}
