//
//  Relay.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Combine

@available(iOS 13.0, *)
public typealias CurrentValueRelay<Output> = CurrentValueSubject<Output, Never>

@available(iOS 13.0, *)
public typealias PassthroughRelay<Output> = PassthroughSubject<Output, Never>
