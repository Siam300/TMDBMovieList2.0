//
//  WatchingListView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 26/1/24.
//

import SwiftUI

struct WatchingListView: View {
    var body: some View {
        VStack {
            //Header: Bookmark title and counter
            CellHeaderView(value: 10, title: "Currently Watching", imageName: "clock.arrow.2.circlepath", color: .green)
                .padding(.top)
            
            //Body: List of Movies
            MovieListView()
        }
        .padding(.top, -70)
    }
}

#Preview {
    WatchingListView()
}
