//
//  ObservableType+Extensions.swift
//  MvvmFoundation
//
//  Created by Даниил Виноградов on 30.05.2023.
//

import Foundation
import RxSwift

public extension ObservableType where Element == Bool {
    var inverted: Observable<Bool> {
        map { !$0 }
    }
}
