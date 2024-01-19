//
//  EditProfileViewModel.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
class EditProfileViewModel: ObservableObject {
    private var uiImage: UIImage?
    
    @Published var user: User
    @Published var fullname = ""
    @Published var bio = ""
    @Published var profileImage: Image?
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    
    init(user: User) {
        self.user = user
        
        if let fullname = user.fullname {
            self.fullname = fullname
        }
        
        if let bio = user.bio {
            self.bio = bio
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.profileImage = Image(uiImage: uiImage)
        self.uiImage = uiImage
    }
    
    
}
