//
//  ContentView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTabView(movie: Movie.Mock_Movies[0], user: User.Mock_Users[0])
    }
}

#Preview {
    ContentView()
}
