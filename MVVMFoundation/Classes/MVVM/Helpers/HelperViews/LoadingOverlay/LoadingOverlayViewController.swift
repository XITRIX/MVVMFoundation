//
//  LoadingOverlayViewController.swift
//  ReManga
//
//  Created by Даниил Виноградов on 07.11.2021.
//

import UIKit

public class LoadingOverlayViewController: UIViewController {
    var backgroundColor: UIColor?

    public init() {
        super.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        if let color = backgroundColor {
            view.backgroundColor = color
        }
    }
}
