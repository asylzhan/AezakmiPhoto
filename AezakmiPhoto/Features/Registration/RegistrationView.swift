//
//  RegistrationView.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 16.09.2024.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel: RegistrationViewModel
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            VStack(spacing: 8) {
                Spacer(minLength: 80)
                Text("Регистрация")
                    .font(.largeTitle)
                    .padding(.bottom, 64)
                
                TextInputRow(labelText: "Email", textFieldPlaceholder: "Email", keyboardType: .emailAddress, textFieldContent: $viewModel.email)
                TextInputRow(labelText: "Password", textFieldPlaceholder: "Password", isSecureField: true, textFieldContent: $viewModel.password)
                Button("Зарегистрироваться") {
                    Task {
                        await viewModel.registerUser()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 46)
                .background(!viewModel.isFormValid ? Color.gray : Color.green)
                .foregroundColor(.white)
                .roundedBorderColor(.clear, cornerRadius: 23)
                .disabled(!viewModel.isFormValid)
                .padding([.top, .bottom], 16)
                Spacer()
            }
            .alert(
                isPresented: $viewModel.hasError,
                error: viewModel.errorMessage,
                actions: {}
            )
            .padding()
        }
    }
}
