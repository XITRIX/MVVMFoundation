//
//  ErrorOverlayViewController.swift
//  ReManga
//
//  Created by Даниил Виноградов on 10.11.2021.
//

import UIKit

public class ErrorOverlayViewController: UIViewController {
    @IBOutlet var errorTitle: UILabel!
    @IBOutlet var errorMessage: UILabel!
    @IBOutlet var errorLogo: UIImageView!
    @IBOutlet var reloadButton: UIButton!

    public var error: MvvmError?

    public init() {
        super.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            reloadButton.layer.cornerCurve = .continuous
        }
        
        if let error = error {
            errorTitle.text = error.title
            errorMessage.text = error.message
            if let retryCallback = error.retryCallback {
                reloadButton.reactive.tap.observeNext(with: retryCallback).dispose(in: bag)
            }
        }
    }
}
