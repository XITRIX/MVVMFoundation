//
//  Api.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import Foundation

protocol ApiProtocol {
    func getSuperSecretMessage(_ password: String) async throws -> String
}

class Api: ApiProtocol {
    func getSuperSecretMessage(_ password: String) async throws -> String {
        try await Task.sleep(nanoseconds: 2000)
        return "Your super secret password:\n\(password)"
    }
}
