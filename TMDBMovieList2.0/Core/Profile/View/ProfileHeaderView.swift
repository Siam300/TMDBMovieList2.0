//
//  ProfileHeaderView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State var showEditProfile = false
    @ObservedObject var viewModel: ProfileViewModel
    
    private var user: User {
        return viewModel.user
    }
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(spacing: 10){
            //Pic and Stats
            HStack(spacing: 10){
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 84, height: 84)
            }
            .padding(.horizontal)
            
            //name and bio
            VStack(alignment: .leading, spacing: 4){
                Text("user.username")
                
                Text("user.fullname")
 
            }
            .font(.title3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            //edit profile button
            Button {
                    showEditProfile.toggle()

            } label: {
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color(.black), lineWidth: 1)
                    }
            }
            Divider()
        }

        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.Mock_Users)
}
