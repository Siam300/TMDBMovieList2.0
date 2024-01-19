//
//  EditProfileView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
//    @Published var fullname = ""
//    @Published var bio = ""
    
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
            //            PhotosPicker(selection: $viewModel.selectedImage) {
            //                VStack {
            //                    if let image = viewModel.profileImage {
            //                        image
            //                            .resizable()
            //                            .foregroundColor(Color.white)
            //                            .background(Color.gray)
            //                            .clipShape(Circle())
            //                            .frame(width: 80, height: 80)
            //                    } else {
            //                        CircularImageProfileView(user: viewModel.user, size: .large)
            //                    }
            //
            //                    Text("Edit profile image")
            //                        .font(.footnote)
            //                        .fontWeight(.semibold)
            //
            //                    Divider()
            //                }
            //            }
            .padding(.vertical, 8)
            
            //Name & bio
            VStack {
//                editProfileRowView(title: "Name", placeholder: "Enter your name...", text: $fullname)
//                editProfileRowView(title: "Bio", placeholder: "Enter your bio...", text: $bio)
            }
            Spacer()
        }
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
    EditProfileView()
}
