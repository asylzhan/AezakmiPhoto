//
//  EditPhotoViewModel.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 18.09.2024.
//

import Foundation

@MainActor
final class EditPhotoViewModel: ObservableObject {
    private var authService: AuthServiceProtocol
    
    @Published var hasError = false
    @Published var errorMessage: AuthError = .someError
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func signOut() async {
        hasError = false
        do {
            try await authService.signOut()
        } catch {
            hasError = true
            errorMessage = .anyError(error: error)
        }
    }
}
