//
//  ContentViewModel.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 26/1/24.
//

import Foundation
import Firebase
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
        
        UserService.shared.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
    }
}
