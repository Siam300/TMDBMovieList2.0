//
//  RegistrationView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 20/1/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var navigateToMainTabView = false
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
//            NavigationLink(destination: MainTabView(),
//                           isActive: $viewModel.didAuthinticateuser,
//                           label: { } )
            VStack(alignment: .leading, spacing: 12) {
                HStack { Spacer() }
                Text("Get Started with TMDB.")
                    .font(.title)
                    .bold()
                
                Text("Create your account")
                    .font(.title)
                    .bold()
                    .foregroundColor(.blue)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        imagePickerPresented.toggle()
                    }, label: {
                        if let profileImage = profileImage {
                            profileImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .padding(.top, 20)
                            
                        } else {
                            Image("plus_photo")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipped()
                                .padding(.top, 20)
                                .foregroundColor(.black)
                        }
                    })
                    .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                        ImagePicker(image: $selectedImage)
                    })
                    
                    Spacer()
                }
                
                VStack(spacing: 32) {
                    CustomTextField(imageName: "envelope", placeHolderText: "Email", isSecureField: false, text: $email)
                        .autocapitalization(.none)
                    
                    CustomTextField(imageName: "person", placeHolderText: "Username", isSecureField: false, text: $username)
                    
                    CustomTextField(imageName: "person", placeHolderText: "Full Name", isSecureField: false, text: $fullname)
                    
                    CustomTextField(imageName: "lock", placeHolderText: "Password", isSecureField: true, text: $password)
                }
                .padding([.top, .horizontal], 32)
            }
            .padding(.leading)
            
            if let image = selectedImage {
                Button {
                    viewModel.register(withEmail: email, password: password, fullname: fullname, username: username, image: image)
                } label: {
                    Text("Complete")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(.blue)
                        .clipShape(Capsule())
                        .padding()
                }
                .padding(.top, 24)
                .shadow(color: .gray, radius: 10)
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have account?")
                        .font(.system(size: 14))
                    
                    Text("Sign In")
                        .font(.system(size: 14, weight: .semibold))
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

#Preview {
    RegistrationView()
}
