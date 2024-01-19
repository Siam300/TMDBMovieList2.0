//
//  MainTabView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    let movie: Movie
    let user: User
    let movieService: MovieServiceProtocol = MovieDataService()
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            TopMovieListView(service: movieService)
                .onAppear{
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                }.tag(0)
            
            SearchView()
                .onAppear{
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            
            ProfileView(user: user)
                .onAppear{
                    selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "person")
                }.tag(2)
        }
    }
}

#Preview {
    MainTabView(movie: Movie.Mock_Movies[0], user: User.Mock_Users[0])
}
