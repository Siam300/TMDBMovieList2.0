//
//  FavoriteView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 26/1/24.
//

import SwiftUI

struct FavoriteView: View {
    var body: some View {
        VStack {
            //Header: Bookmark title and counter
            CellHeaderView(value: 10, title: "Favorite", imageName: "star.fill", color: .yellow)
                .padding(.top)
            
            //Body: List of Movies
            MovieListView()
        }
        .padding(.top, -70)
    }
}

#Preview {
    FavoriteView()
}
