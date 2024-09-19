//
//  SignInViewModel.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 16.09.2024.
//

import Foundation
import FirebaseAuth
import Combine

struct User: Identifiable {
    let id: String
    let email: String
}

enum AuthError: LocalizedError {
    case someError
    case anyError(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .someError:
            return "Something went wrong"
        case .anyError(let error):
            return error.localizedDescription
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .someError:
            return "Please try again."
        case .anyError(let error):
            return error.localizedDescription
        }
    }
}

@MainActor
final class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var currentUser: User? = nil
    @Published var isFormValid = false
    @Published var hasError = false
    @Published var errorMessage: AuthError = .someError
    @Published var isSignedIn = false
    @Published var isLoading = false
    
    private(set) var authService: AuthServiceProtocol
    
    private var emailValidator = EmailValidator()
    private var passwordValidator = PasswordValidator()
    private var validator = Validator()
    
    private var cancellable: Set<AnyCancellable> = []

    var user: User {
        return currentUser ?? User(id: "", email: "")
    }
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
        validator.registerValidator(emailValidator)
        validator.registerValidator(passwordValidator)
        
        authService.addAuthStateChangeListener {[weak self] user in
            guard let self = self else { return }
            guard let user else {
                self.currentUser = nil
                self.isSignedIn = false
                return
            }
            
            debugPrint("Current User: \(user)")
            self.currentUser = user
            self.isSignedIn = true
        }
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
    
    func signIn() async {
        isLoading = true
        hasError = false
        do {
            let user = try await authService.signIn(email: email, password: password)
            isLoading = false
            debugPrint("Signed user: \(user)")
        } catch {
            isLoading = false
            hasError = true
            errorMessage = .anyError(error: error)
        }
    }
    
    deinit {
        cancellable = []
    }
}

//private extension SignInViewModel {
//    private var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
//        $password
//            .debounce(for: 0.5, scheduler: DispatchQueue.main)
//            .removeDuplicates()
//            .map { $0.count >= 8 }
//            .eraseToAnyPublisher()
//    }
//    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
//        $email
//            .map {
//                let predicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
//                return predicate.evaluate(with: $0)
//            }
//            .eraseToAnyPublisher()
//    }
//    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
//        Publishers.CombineLatest(isEmailValidPublisher, isPasswordValidPublisher)
//            .map { isEmailValid, isPasswordValid in
//                return isEmailValid && isPasswordValid
//            }
//            .eraseToAnyPublisher()
//    }
//}
