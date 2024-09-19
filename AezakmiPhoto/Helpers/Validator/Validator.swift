//
//  Validator.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 18.09.2024.
//

import Foundation
import Combine

class Validator {
    private var validators: [ValidatorProtocol] = []
    private var cancellables = Set<AnyCancellable>()
    
    var isFormValidPublisher: AnyPublisher<Bool, Never> {
        guard !validators.isEmpty else {
            return Just(false).eraseToAnyPublisher()
        }
        
        return validators
            .map { $0.isValidPublisher }
            .reduce(Just(true).eraseToAnyPublisher()) { combined, validator in
                Publishers.CombineLatest(combined, validator)
                    .map { $0 && $1 }
                    .eraseToAnyPublisher()
            }
    }
    
    func registerValidator(_ validator: ValidatorProtocol) {
        validators.append(validator)
    }
}


