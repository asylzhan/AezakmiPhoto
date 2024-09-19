//
//  EmailValidator.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 18.09.2024.
//

import Foundation
import Combine

class EmailValidator: ValidatorProtocol {
    @Published var email: String = ""
    
    var isValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                let predicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
                debugPrint("Emit: \(email)")
                return predicate.evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }
}

