//
//  PasswordValidator.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 18.09.2024.
//

import Foundation
import Combine

class PasswordValidator: ValidatorProtocol {
    @Published var password: String = ""
    
    var isValidPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.25, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { $0.count >= 8 }
            .eraseToAnyPublisher()
    }
}


