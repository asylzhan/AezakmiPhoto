//
//  MainView.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 17.09.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var signInViewModel = SignInViewModel(authService: AuthService())
    
    var body: some View {
        ZStack {
            if signInViewModel.isSignedIn {
                EditPhotoView(viewModel: EditPhotoViewModel(authService: signInViewModel.authService))
            } else {
                SignInView(viewModel: signInViewModel)
            }
        }
        .background(.lightPurple)
    }
    
}
