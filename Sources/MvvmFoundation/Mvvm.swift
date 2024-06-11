//
//  Mvvm.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 30/10/2023.
//

import Foundation

public class Mvvm: @unchecked Sendable {
    public static var shared = Mvvm()

    public let container = Container()
    public let router = Router()

    private init() {}
}
