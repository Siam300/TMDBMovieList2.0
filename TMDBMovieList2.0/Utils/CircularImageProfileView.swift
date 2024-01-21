//
//  CircularImageProfileView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 22/1/24.
//

import SwiftUI
import Kingfisher

struct CircularImageProfileView: View {
    var user: User?
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 124, height: 124)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 124, height: 124)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularImageProfileView()
}
