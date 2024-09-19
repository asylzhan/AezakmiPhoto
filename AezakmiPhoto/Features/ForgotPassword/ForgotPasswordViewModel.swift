//
//  ForgotPasswordViewModel.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 17.09.2024.
//

import Foundation
import Combine

@MainActor
final class ForgotPasswordViewModel: ObservableObject {
    @Published var email = ""
    @Published var hasError = false
    @Published var errorMessage = ""
    @Published var isFormValid = false
    @Published var isLoading = false
    
    private let authService: AuthServiceProtocol
    
    private var emailValidator = EmailValidator()
    private var validator = Validator()
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
        
        validator.registerValidator(emailValidator)
        
        $email
            .assign(to: \.email, on: emailValidator)
            .store(in: &cancellable)
        
        validator.isFormValidPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellable)
    }
    
    func resetPassword() async {
        isLoading = true
        hasError = false
        do {
            try await authService.resetPassword(email: email)
            isLoading = false
            debugPrint("Reset password has been sent!")
        } catch {
            isLoading = false
            hasError = true
            errorMessage = error.localizedDescription
        }
    }
}
