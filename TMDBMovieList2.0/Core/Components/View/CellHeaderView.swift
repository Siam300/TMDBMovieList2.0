//
//  CellHeaderView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 26/1/24.
//

import SwiftUI

struct CellHeaderView: View {
    let value: Int
    let title: String
    let imageName: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
                .padding(6)
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(6)
            
            Text(title)
            
            Spacer()
            
            Text("\(value)")
                .padding(.trailing, 20)
        }
        .font(.title)
        .fontWeight(.semibold)
        .padding()
        .background(Color(#colorLiteral(red: 0.9429038763, green: 0.9489961267, blue: 0.9598817229, alpha: 1)))
    }
}

#Preview {
    CellHeaderView(value: 10, title: "Bookmarked", imageName: "bookmark.fill", color: .cyan)
}
