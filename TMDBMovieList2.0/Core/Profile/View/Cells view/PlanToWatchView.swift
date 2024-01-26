//
//  PlanToWatchView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 26/1/24.
//

import SwiftUI

struct PlanToWatchView: View {
    var body: some View {
        VStack {
            //Header: Bookmark title and counter
            CellHeaderView(value: 10, title: "Plan to Watch", imageName: "doc.richtext.fill.zh", color: .gray)
                .padding(.top)
            
            //Body: List of Movies
            MovieListView()
        }
        .padding(.top, -70)
    }
}

#Preview {
    PlanToWatchView()
}
