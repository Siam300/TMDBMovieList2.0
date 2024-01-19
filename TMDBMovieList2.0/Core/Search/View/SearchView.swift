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
            ScrollView {
                ForEach((0 ... 10), id: \.self) { user in
                        HStack{
                            Text("Movie Image")
                            
                            VStack(alignment: .leading) {
                                Text("Movie Name")
                                    .fontWeight(.semibold)
                                Text("Movie Rating")
                            }
                            .font(.footnote)
                            Spacer()
                        }
                        .foregroundColor(Color.black)
                        .padding(.horizontal)
                }
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search")
            }
            .navigationTitle("Search")
        }
    }
}

#Preview {
    SearchView()
}
