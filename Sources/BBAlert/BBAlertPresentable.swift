//
//  BBAlertPresentable.swift
//  BBAlert
//
//  Created by Bibin Jacob Pulickal on 17/05/20.
//

import UIKit

public protocol BBAlertPresentable {

    func present(_ viewControllerToPresent: UIViewController,
                 completion: (() -> Void)?)
    func present(_ viewControllerToPresent: UIViewController,
                 animated flag: Bool,
                 completion: (() -> Void)?)
}

extension UIViewController: BBAlertPresentable { }

extension BBAlertPresentable {

    public func present(_ viewControllerToPresent: UIViewController, completion: (() -> Void)? = nil) {
        present(viewControllerToPresent, animated: true, completion: completion)
    }
}

extension BBAlertPresentable {

    public func presentBBAlert(title: String?                             = nil,
                               message: String?                           = nil,
                               style: BBAlert.Style                       = .alert,
                               actions: [String: UIAlertAction.Style]     = [:],
                               setup: ((BBAlert) -> Void)?                = nil,
                               actionHandler: ((UIAlertAction) -> Void)?  = nil,
                               completion: ((BBAlert) -> Void)?           = nil) {

        let alert = BBAlert(title: title, message: message, style: style)

        for (key, value) in actions {
            alert.addAction(UIAlertAction(title: key, style: value, handler: actionHandler))
        }
        setup?(alert)

        present(alert) {
            completion?(alert)
        }
    }
}
