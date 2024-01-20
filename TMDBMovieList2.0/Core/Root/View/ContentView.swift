//
//  ContentView.swift
//  TMDBMovieList2.0
//
//  Created by Auto on 19/1/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MainTabView()
            } else {
                LogInView()
            }
        }
    }
}

#Preview {
    ContentView()
}
