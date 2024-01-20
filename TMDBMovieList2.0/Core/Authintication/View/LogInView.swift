//
//  LogInView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 20/1/24.
//

import SwiftUI

struct LogInView: View {
    @State private var email = ""
    @State private var password = ""
//    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 12) {
                    HStack { Spacer() }
                    
                    Text("Welcome to")
                        .font(.title)
                        .bold()
                        .foregroundColor(.blue)
                    
                    Text("TMDB.")
                        .font(.title)
                        .bold()
                    
                    VStack(spacing: 40) {
                        CustomTextField(imageName: "envelope", placeHolderText: "Email", isSecureField: false, text: $email)
                            .autocapitalization(.none)
                        
                        CustomTextField(imageName: "lock", placeHolderText: "Password", isSecureField: true, text: $password)
                    }
                    .padding([.top, .horizontal], 32)
                }
                .padding(.leading)
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: Text("Reset Password")) {
                        Text("Forgot Password?")
                            .font(.system(size: 13, weight: .semibold))
                            .padding(.top)
                            .padding(.trailing)
                    }
                }
                
                Button(action: {
//                    viewModel.logIn(withEmail: email, password: password)
                }, label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(.blue)
                        .clipShape(Capsule())
                        .padding()
                })
                .shadow(color: .gray, radius: 10)
                
                Spacer()
                
                NavigationLink(destination: RegistrationView()
                    .navigationBarBackButtonHidden(true)) {
                    HStack {
                        Text("Don't have account?")
                            .font(.system(size: 14))
                        
                        Text("Sign Up")
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
                .padding(.bottom, 32)
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding(.top, -56)
    }
}

#Preview {
    LogInView()
}
