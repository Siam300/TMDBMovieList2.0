//
//  TextfieldModifier.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 20/1/24.
//

import SwiftUI

struct TextfieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
            .padding(.top)
    }
}
