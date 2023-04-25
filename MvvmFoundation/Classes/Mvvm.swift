//
//  Mvvm.swift
//  MvvmWorkshop
//
//  Created by Даниил Виноградов on 16.03.2023.
//

import UIKit

public class Mvvm {
    public static var shared = Mvvm()

    public let container = Container()
    public let router = Router()

    private init() {}
}
