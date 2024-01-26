//
//  SearchView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            MovieListView()
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search")
                .navigationTitle("Search")
        }
    }
}

#Preview {
    SearchView()
}
