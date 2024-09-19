//
//  ValidatorProtocols.swift
//  AezakmiPhoto
//
//  Created by Zhailibi on 18.09.2024.
//

import Foundation
import Combine

protocol ValidatorProtocol {
    var isValidPublisher: AnyPublisher<Bool, Never> { get }
}
