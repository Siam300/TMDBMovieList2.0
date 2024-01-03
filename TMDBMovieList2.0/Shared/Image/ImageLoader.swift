//
//  ImageLoader.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 2/1/24.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: Image?
    private let urlString: String

    init(imagePath: String) {
        self.urlString = "https://image.tmdb.org/t/p/w500" + imagePath
        Task { await loadImage() }
    }

    @MainActor
    private func loadImage() async {
        if let cached = ImageCache.shared.get(forKey: urlString) {
            self.image = Image(uiImage: cached)
            return
        }

        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiImage = UIImage(data: data) else { return }
            ImageCache.shared.set(uiImage, forKey: urlString)
            self.image = Image(uiImage: uiImage)
        } catch {
            print("DEBUG: Failed to fetch image with error \(error.localizedDescription)")
        }
    }
}

