//
//  Relay.swift
//  MvvmFoundation
//
//  Created by Daniil Vinogradov on 29/10/2023.
//

import Combine

public typealias CurrentValueRelay<Output> = CurrentValueSubject<Output, Never>
public typealias PassthroughRelay<Output> = PassthroughSubject<Output, Never>
