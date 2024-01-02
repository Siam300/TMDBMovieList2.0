//
//  MovieImageView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 2/1/24.
//

import SwiftUI

struct MovieImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(imagePath: String) {
        imageLoader = ImageLoader(imagePath: imagePath)
    }
    
    var body: some View {
        if let image = imageLoader.image {
            image
                .resizable()
                .scaledToFit()
        } else {
            ProgressView()
        }
    }
}


//#Preview {
//    MovieImageView()
//}
