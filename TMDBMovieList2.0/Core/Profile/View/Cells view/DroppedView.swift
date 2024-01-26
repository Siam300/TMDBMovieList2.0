//
//  DroppedView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 26/1/24.
//

import SwiftUI

struct DroppedView: View {
    var body: some View {
        VStack {
            //Header: Bookmark title and counter
            CellHeaderView(value: 10, title: "Dropped", imageName: "xmark.app.fill", color: .red)            
            //Body: List of Movies
            MovieListView()
        }
        .padding(.top, -70)
    }
}

#Preview {
    DroppedView()
}
