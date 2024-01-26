//
//  AuthService.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 26/1/24.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import FirebaseAuth

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        Task { try await loadUserData() }
    }
    
    @MainActor
    func login(withemail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        }
        catch {
            print("Debug: Failed to login with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("created user")
            await uploadUserData(uid: result.user.uid, email: email, username: username)
            print("Uploaded user data")
        } catch {
            print("Debug: Failed to register user with error \(error.localizedDescription)")
        }
    }
    
    private func uploadUserData(uid: String, email: String, username: String) async {
        let user = User(id: uid, username: username, email: email)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
    }
}

