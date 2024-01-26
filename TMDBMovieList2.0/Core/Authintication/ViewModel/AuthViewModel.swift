//
//  AuthViewModel.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 20/1/24.
//

import Firebase
import FirebaseAuth
import UIKit

class AuthViewModel: NSObject, ObservableObject {
    @Published var didAuthinticateuser = false
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    private var tempCurrentUser: FirebaseAuth.User?
    
    static let shared = AuthViewModel()
    
    override init() {
        super .init()
        userSession = Auth.auth().currentUser
        
        fetchUser()
    }
    
    func logIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Login failed: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String, image: UIImage) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Registration failed with error \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            self.tempCurrentUser = user
            
            let data: [String: Any] = [KEY_EMAIL: email,
                                       KEY_FULLNAME: fullname,
                                       KEY_USERNAME: username,]
            
            COLLECTION_USERS.document(user.uid).setData(data) { _ in
                
                // Upload profile image
                guard let uid = self.tempCurrentUser?.uid else { return }
                
                ImageUploader.uploadImage(image: image) { imageUrl in
                    COLLECTION_USERS.document(uid).updateData([KEY_PROFILE_IMAGE_URL: imageUrl]) { _ in
                        self.userSession = self.tempCurrentUser
                        self.fetchUser()
                    }
                }
                
                self.didAuthinticateuser = true
                print("DEBUG: Registration successful")
            }
        }
    }

    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
            
        }
    }
    
    func signOut() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
}
