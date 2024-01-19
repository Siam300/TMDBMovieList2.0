//
//  ProfileViewModel.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
