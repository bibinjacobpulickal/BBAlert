//
//  BBAlert.swift
//  BBAlert
//
//  Created by Bibin Jacob Pulickal on 17/05/20.
//

import UIKit

public typealias BBAlert = UIAlertController

public extension BBAlert {

    convenience init(title: String = "", message: String = "") {
        self.init(title: title, message: message, preferredStyle: .alert)

        pruneNegativeWidthConstraints()
    }

    func pruneNegativeWidthConstraints() {
        for subView in view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}

public extension BBAlert {

    var backgroundColor: UIColor? {
        set {
            view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = newValue
        }
        get {
            view.subviews.first?.subviews.first?.subviews.first?.backgroundColor
        }
    }

    var textColor: UIColor? {
        set {
            titleTextColor   = newValue
            messageTextColor = newValue
        }
        get {
            titleTextColor
        }
    }

    var titleTextColor: UIColor? {
        set {
            guard let foregroundColor = newValue else { return }
            let attributedTitle = NSAttributedString(string: title ?? "", attributes: [.foregroundColor: foregroundColor])
            setValue(attributedTitle, forKey: "attributedTitle")
        }
        get {
            let attributedTitle = value(forKey: "attributedTitle") as? NSAttributedString
            var color: UIColor?
            for (key, value) in attributedTitle?.attributes(at: 0, effectiveRange: nil) ?? [:] {
                if key == .foregroundColor, let value = value as? UIColor {
                    color = value
                }
            }
            return color
        }
    }

    var messageTextColor: UIColor? {
        set {
            guard let foregroundColor = newValue else { return }
            let attributedMessage = NSAttributedString(string: message ?? "", attributes: [.foregroundColor: foregroundColor])
            setValue(attributedMessage, forKey: "attributedMessage")
        }
        get {
            let attributedMessage = value(forKey: "attributedMessage") as? NSAttributedString
            var color: UIColor?
            for (key, value) in attributedMessage?.attributes(at: 0, effectiveRange: nil) ?? [:] {
                if key == .foregroundColor, let value = value as? UIColor {
                    color = value
                }
            }
            return color
        }
    }

    var titleFont: UIFont? {
        set {
            guard let font = newValue else { return }
            let attributedTitle = NSAttributedString(string: title ?? "", attributes: [.font: font])
            setValue(attributedTitle, forKey: "attributedTitle")
        }
        get {
            let attributedTitle = value(forKey: "attributedTitle") as? NSAttributedString
            var font: UIFont?
            for (key, value) in attributedTitle?.attributes(at: 0, effectiveRange: nil) ?? [:] {
                if key == .font, let value = value as? UIFont {
                    font = value
                }
            }
            return font
        }
    }

    var messageFont: UIFont? {
        set {
            guard let font = newValue else { return }
            let attributedMessage = NSAttributedString(string: message ?? "", attributes: [.font: font])
            setValue(attributedMessage, forKey: "attributedMessage")
        }
        get {
            let attributedMessage = value(forKey: "attributedMessage") as? NSAttributedString
            var font: UIFont?
            for (key, value) in attributedMessage?.attributes(at: 0, effectiveRange: nil) ?? [:] {
                if key == .font, let value = value as? UIFont {
                    font = value
                }
            }
            return font
        }
    }

    func dismiss(completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }
}
