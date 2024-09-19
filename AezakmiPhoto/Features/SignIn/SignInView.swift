//
//  SignInView.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 16.09.2024.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel: SignInViewModel
    @State var showForgotPassword = false
    @State var showRegistration = false
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            VStack(spacing: 8) {
                Spacer(minLength: 80)
                Text("Авторизация")
                    .font(.largeTitle)
                    .padding(.bottom, 64)
                
                TextInputRow(labelText: "Email", textFieldPlaceholder: "Email", keyboardType: .emailAddress, textFieldContent: $viewModel.email)
                TextInputRow(labelText: "Password", textFieldPlaceholder: "Password", isSecureField: true, textFieldContent: $viewModel.password)
                Button("Войти") {
                    Task {
                        await viewModel.signIn()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 46)
                .background(!viewModel.isFormValid ? Color.gray : Color.green)
                .foregroundColor(.white)
                .roundedBorderColor(.clear, cornerRadius: 23)
                .disabled(!viewModel.isFormValid)
                .padding([.top, .bottom], 16)
                
                Button("Забыли пароль?​​") {
                    showForgotPassword = true
                }
                Button("Регистрация​​") {
                    showRegistration = true
                }
                Spacer()
            }
            .sheet(isPresented: $showForgotPassword, content: {
                ForgotPasswordView(
                    viewModel: ForgotPasswordViewModel(authService: viewModel.authService)
                )
                .background(.lightPurple)
            })
            .sheet(isPresented: $showRegistration, content: {
                RegistrationView(
                    viewModel: RegistrationViewModel(authService: viewModel.authService)
                )
                .background(.lightPurple)
            })
            .alert(
                isPresented: $viewModel.hasError,
                error: viewModel.errorMessage,
                actions: {}
            )
            .padding()
        }
        
    }
}
