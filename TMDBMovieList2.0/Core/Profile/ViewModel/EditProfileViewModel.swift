//
//  EditProfileViewModel.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import Firebase
import FirebaseStorage
import SwiftUI
import PhotosUI

@MainActor
class EditProfileViewModel: ObservableObject {
    var uiImage: UIImage?
    
    @Published var user: User
    @Published var fullname = ""
    @Published var bio = ""
    @Published var profileImage: Image?
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    
    init(_ user: User) {
        self.user = user
    }
    
    var isFullnameEmpty: Bool {
            return fullname.isEmpty
        }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.profileImage = Image(uiImage: uiImage)
        self.uiImage = uiImage
    }
    
    func updateName(_ name: String) {
        guard let uid = user.id else { return }
        
        if !name.isEmpty && user.fullname != name {
            let data = [KEY_FULLNAME: name]
            
            COLLECTION_USERS.document(uid).updateData(data) { error in
                if let error = error {
                    print("DEBUG: Failed tp update full name with error \(error.localizedDescription)")
                    return
                }
                print("DEBUG: Update fullname successful")
                self.user.fullname = name
            }
        }
    }
    
    func updateProfileImage(_ image: UIImage) {
        guard let uid = user.id else { return }
        
        if let image = uiImage {
            let storagePath = Storage.storage().reference(forURL: user.profileImageUrl)
            
            storagePath.delete { error in
                if let error = error {
                    print("DEBUG: Error deleting user profile image \(error.localizedDescription)")
                    return
                }
                
                ImageUploader.uploadImage(image: image) { imageUrl in
                    let data = [KEY_PROFILE_IMAGE_URL: imageUrl]
                    COLLECTION_USERS.document(uid).updateData(data) { error in
                        if let error = error {
                            print("DEBUG: Failed tp update profile image with error \(error.localizedDescription)")
                            return
                        }
                        print("DEBUG: Profile image update successful")
                        self.user.profileImageUrl = imageUrl
                    }
                }
            }
        }
    }
}
