//
//  MovieDetailsView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 31/12/23.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie: TopRatedMovies
    
    var body: some View {
        ZStack {
            Color("movieDetails")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    //Header
                    HStack {
                        VStack(alignment: .leading) {
                            //Movie Details
                            Text("\(movie.title)")
                                .font(.headline)
                                .fontWeight(.heavy)
                            
                            Text(String(format: "Rating: %.1f/10", movie.voteAverage))
                                .font(.subheadline)
                            
                            Text("Vote Count: \(movie.voteCount)")
                                .font(.subheadline)
                            
                            Text(String(format: "Popularity: %.3f", movie.popularity))
                                .font(.subheadline)
                            
                            Text("Release Date: \(movie.releaseDate)")
                                .font(.subheadline)
                            
                        }
                        
                        Spacer()
                        
                        //Poster
                        MovieImageView(imagePath: movie.posterPath ?? "")
                            .cornerRadius(6)
                            .frame(width: 120, height : 200)
                    }
                    
                    //OverView
                    Text("Overview: \(movie.overview)")
                        .font(.subheadline)
                    
                    //backdrop
                    MovieImageView(imagePath: movie.backdropPath ?? "")
                        .cornerRadius(6)
                        .frame(height: 200)
                }
                .padding(.horizontal)
                .navigationTitle(movie.title)
                .toolbarTitleDisplayMode(.inline)
            }
        }
    }
}

//#Preview {
//    MovieDetailsView()
//}
