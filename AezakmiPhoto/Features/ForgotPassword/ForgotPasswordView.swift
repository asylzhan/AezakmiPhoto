//
//  ForgotPasswordView.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 17.09.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var viewModel: ForgotPasswordViewModel
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            VStack(spacing: 8) {
                Spacer()
                Text("Забыли пароль")
                    .font(.largeTitle)
                    .padding(.bottom, 64)
                TextInputRow(labelText: "Email", textFieldPlaceholder: "Email", textFieldContent: $viewModel.email)
                Button("Отправить") {
                    Task {
                        await viewModel.resetPassword()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 46)
                .background(!viewModel.isFormValid ? Color.gray : Color.green)
                .foregroundColor(.white)
                .roundedBorderColor(.clear, cornerRadius: 23)
                .disabled(!viewModel.isFormValid)
                .padding(.top, 16)
                Spacer()
            }
            .padding()
        }
    }
}
