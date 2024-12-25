//
//  File.swift
//
//
//  Created by Daniil Vinogradov on 08/11/2023.
//

@preconcurrency import Combine
import SwiftUI

public extension CurrentValueSubject {
    var binding: Binding<Output> {
        Binding(get: {
            self.value
        }, set: {
            self.send($0)
        })
    }
}
