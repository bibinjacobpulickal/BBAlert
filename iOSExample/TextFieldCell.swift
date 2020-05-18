//
//  TextFieldCell.swift
//  iOSExample
//
//  Created by Bibin Jacob Pulickal on 15/05/20.
//

import UIKit

protocol TextFieldCellDelegate: AnyObject {
    func textFieldCell(_ textFieldCell: TextFieldCell, updatedText text: String?)
}

class TextFieldCell: UITableViewCell {

    var section = Section.title
    let textField = UITextField()

    weak var delegate: TextFieldCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(textField)

        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)

        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor)])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handleTextChange() {
        delegate?.textFieldCell(self, updatedText: textField.text)
    }
}
