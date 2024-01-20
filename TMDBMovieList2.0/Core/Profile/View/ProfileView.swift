//
//  ProfileView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: EditProfileViewModel
    @State private var showEditProfile = false
    
    init(user: User) {
            self.viewModel = EditProfileViewModel(user)
        }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Header
                ProfileHeaderView(user: viewModel.user)
                
                // Body view
                VStack(spacing: 1) {
                    ForEach(ProfileCellViewModel.allCases, id: \.self) { viewModel in
                        ProfileCellView(viewModel: viewModel)
                    }
                }
                
                Spacer()
                
                Button(
                    action: {
                        AuthViewModel.shared.signOut()
                    }, label: {
                        Text("Log Out")
                            .frame(width: UIScreen.main.bounds.width, height: 40)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    })
                
                Spacer()
            }
            .navigationTitle("Profile")
        }
    }
}


#Preview {
    ProfileView(user: User.Mock_Users)
}
