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
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user))
    }
    
    var body: some View {
        VStack {
            //toobar
            VStack {
                HStack {
                    Button("Cancel") {
                        print("DEBUG: Cancel button pressed....")
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    
                    Button {
                        print("DEBUG: Done button pressed....")
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
                                .frame(width: 124, height: 124)
                        } else {
                            CircularImageProfileView(user: viewModel.user)
                        }
                        
                        Text("Edit profile image")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .padding()
                }
                
                Divider()
            }
            
        }
        .padding(.vertical, 8)
        
        //Name & bio
        VStack(spacing: 15){
            editProfileRowView(title: "Fullname", placeholder: "Update your fullname...", text: $viewModel.fullname)
//            editProfileRowView(title: "Bio", placeholder: "Enter your bio...", text: $viewModel.bio)
            
            Divider()
            
            Button {
                print("Full name updated")
                viewModel.updateName(viewModel.fullname)
            } label: {
                Text("Update Fullname")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(width: 360, height: 40)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(.black), lineWidth: 1)
                    }
            }
            .disabled(viewModel.isFullnameEmpty)
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
