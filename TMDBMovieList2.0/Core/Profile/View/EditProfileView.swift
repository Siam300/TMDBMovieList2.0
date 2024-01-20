//
//  EditProfileView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            //toobar
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    
                    Button {
                        Task {
                            dismiss()
                        }
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)
                Divider()
            }
            
            //edit profile pic
            VStack {
                PhotosPicker(selection: $viewModel.selectedImage) {
                    VStack {
                        if let image = viewModel.profileImage {
                            image
                                .resizable()
                                .foregroundColor(Color.white)
                                .background(Color.gray)
                                .clipShape(Circle())
                                .frame(width: 84, height: 84)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 84, height: 84)
                                .clipShape(Circle())
                                .foregroundColor(Color(.systemGray4))
                        }
                        
                        Text("Edit profile image")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
                
                Divider()
            }
            
        }
        .padding(.vertical, 8)
        
        //Name & bio
        VStack {
            editProfileRowView(title: "Name", placeholder: "Enter your name...", text: $viewModel.fullname)
            editProfileRowView(title: "Bio", placeholder: "Enter your bio...", text: $viewModel.bio)
        }
        Spacer()
    }
}

struct editProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            VStack {
                TextField(placeholder, text: $text)
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

#Preview {
    EditProfileView(user: User.Mock_Users)
}
