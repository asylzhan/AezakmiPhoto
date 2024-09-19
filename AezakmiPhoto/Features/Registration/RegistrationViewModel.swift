//
//  RegistrationViewModel.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 16.09.2024.
//

import Foundation
import Combine

@MainActor
final class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var currentUser: User? = nil
    @Published var isFormValid = false
    @Published var hasError = false
    @Published var errorMessage: AuthError = .someError
    @Published var isSignedIn = false
    @Published var isLoading = false
    
    private let authService: AuthServiceProtocol
    
    private var emailValidator = EmailValidator()
    private var passwordValidator = PasswordValidator()
    private var validator = Validator()
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
        validator.registerValidator(emailValidator)
        validator.registerValidator(passwordValidator)
        
        $email
            .assign(to: \.email, on: emailValidator)
            .store(in: &cancellable)
        $password
            .assign(to: \.password, on: passwordValidator)
            .store(in: &cancellable)
        
        validator.isFormValidPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellable)
    }
    
    func registerUser() async {
        isLoading = true
        hasError = false
        do {
            let user = try await authService.registerUser(email: email, password: password)
            isLoading = false
            debugPrint("Registered user: \(user)")
        } catch {
            isLoading = false
            hasError = true
            errorMessage = .anyError(error: error)
        }
    }
}
