//
//  AuthService.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 17.09.2024.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    func registerUser(email: String, password: String) async throws -> User
    func signIn(email: String, password: String) async throws -> User
    func signOut() async throws
    func resetPassword(email: String) async throws
    func addAuthStateChangeListener(_ listener: @escaping (User?) -> Void)
}

final class AuthService: AuthServiceProtocol {
    private var handler: NSObjectProtocol?
    
    func registerUser(email: String, password: String) async throws -> User {
        do {
            let data = try await Auth.auth().createUser(withEmail: email, password: password)
            return User(id: data.user.uid, email: data.user.email ?? "")
        } catch {
            throw error
        }
    }
    
    func signIn(email: String, password: String) async throws -> User {
        do {
            let data = try await Auth.auth().signIn(withEmail: email, password: password)
            return User(id: data.user.uid, email: data.user.email ?? "")
        } catch {
            throw error
        }
    }
    
    func resetPassword(email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            throw error
        }
    }
    
    func signOut() async throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw error
        }
    }
    
    func addAuthStateChangeListener(_ listener: @escaping (User?) -> Void) {
        handler = Auth.auth().addStateDidChangeListener{ _, user in
            debugPrint("Auth state changes: \(user)")
            if let user {
                let currentUser = User(id: user.uid, email: user.email ?? "")
                listener(currentUser)
            } else {
                listener(nil)
            }
        }
    }
    
    deinit {
        if let handler = handler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
}
