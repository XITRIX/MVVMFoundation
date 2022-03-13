//
//  MvvmViewModelState.swift
//  ReManga
//
//  Created by Даниил Виноградов on 09.11.2021.
//

import Foundation

public struct MvvmError: Equatable, Error {
    public let title: String
    public let message: String?
    public let retryCallback: (()->())?

    public static func == (lhs: MvvmError, rhs: MvvmError) -> Bool {
        lhs.title == rhs.title && lhs.message == rhs.message
    }

    public init(_ error: Error, retryCallback: (()->())?) {
        title = "Error"
        message = error.localizedDescription
        self.retryCallback = retryCallback
    }
}

public enum MvvmViewModelState: Equatable {
    case done
    case processing
    case error(MvvmError)
}
