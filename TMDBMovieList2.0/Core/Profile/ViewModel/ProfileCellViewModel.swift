//
//  ProfileCellViewModel.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 20/1/24.
//

import SwiftUI

enum ProfileCellViewModel: Int, CaseIterable {
    case bookmarked
    case favorite
    case watchinglist
    case completed
    case plantoWatch
    case dropped
    
    var title: String {
        switch self {
        case .bookmarked: return "Bookmaked"
        case .favorite: return "Favorite"
        case .watchinglist: return "Currently Watching"
        case .completed: return "Completed"
        case .plantoWatch: return "Plan to Watch"
        case .dropped: return "Dropped"
        }
    }
    
    var imageName: String {
        switch self {
        case .bookmarked: return "bookmark.fill"
        case .favorite: return "star.fill"
        case .watchinglist: return "clock.arrow.2.circlepath"
        case .completed: return "checkmark.circle.fill"
        case .plantoWatch: return "doc.richtext.fill.zh"
        case .dropped: return "xmark.app.fill"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .bookmarked: return .cyan
        case .favorite: return .yellow
        case .watchinglist: return .green
        case .completed: return .purple
        case .plantoWatch: return .gray
        case .dropped: return .red
        }
    }
}
