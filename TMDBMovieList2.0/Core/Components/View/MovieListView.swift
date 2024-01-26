//
//  MovieListView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 26/1/24.
//

import SwiftUI

struct MovieListView: View {
    var body: some View {
        ScrollView {
            ForEach((0 ... 50), id: \.self) { user in
                HStack{
                    Text("Movie Image")
                    
                    VStack(alignment: .leading) {
                        Text("Movie Name")
                            .fontWeight(.semibold)
                        Text("Movie Rating")
                    }
                    .font(.footnote)
                }
                .foregroundColor(Color.black)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    MovieListView()
}
