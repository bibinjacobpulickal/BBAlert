//
//  BBAlertDismissible.swift
//  BBAlert
//
//  Created by Bibin Jacob Pulickal on 09/09/20.
//

import UIKit

public protocol BBAlertDismissible {

    func dismiss(completion: (() -> Void)?)
    func dismiss(animated flag: Bool,
                 completion: (() -> Void)?)
}

extension UIViewController: BBAlertDismissible { }

extension BBAlertDismissible {

    public func dismiss(completion: (() -> Void)?) {
        dismiss(animated: true, completion: completion)
    }
}
