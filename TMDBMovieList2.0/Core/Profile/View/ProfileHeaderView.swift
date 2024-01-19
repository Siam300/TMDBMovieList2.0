//
//  ProfileHeaderView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State var showEditProfile = false
    
    var body: some View {
        VStack(spacing: 10){
            //Pic and Stats
            HStack(spacing: 10){
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
                
                
                HStack {

                }
            }
            .padding(.horizontal)
            
            //name and bio
            VStack(alignment: .leading, spacing: 4){
                Text("user.username")
 
            }
            .font(.footnote)
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
            
            Spacer()
        }

        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView()
        }
    }
}

#Preview {
    ProfileHeaderView()
}
