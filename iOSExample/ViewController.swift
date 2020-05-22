//
//  ViewController.swift
//  iOSExample
//
//  Created by Bibin Jacob Pulickal on 15/05/20.
//

import UIKit
import BBAlert

class ViewController: UITableViewController {

    var selectedTitleText: String   = "BBAlert"
    var selectedMessageText: String = "This is an alert message."
    var selectedActionText: String  = "Okay"

    var selectedBackgroundColorIndex = 0
    var selectedTextColorIndex       = 0
    var selectedButtonTextColorIndex = 0

    override func loadView() {
        super.loadView()

        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: TextFieldCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title                                   = "BBAlert"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem                      = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(presentAlert))
    }

    @objc private func presentAlert() {
        let actions: [String: UIAlertAction.Style] = [selectedActionText: .default, "Cancel": .cancel, "Destroy": .destructive]
        presentBBAlert(title: selectedTitleText, message: selectedMessageText, actions: actions, setup: { alert in
            alert.titleFont       = .boldSystemFont(ofSize: 20)
            alert.messageFont     = .systemFont(ofSize: 16)
            alert.backgroundColor = Color.allCases[self.selectedBackgroundColorIndex].color
            alert.textColor       = Color.allCases[self.selectedTextColorIndex].color
            alert.buttonTextColor = Color.allCases[self.selectedButtonTextColorIndex].color ?? .white
        }, actionHandler: { action in
            if action.title == self.selectedActionText {
                print("Selected \(self.selectedActionText)")
            }
        }) { _ in
            print("Perform stuff after completion.")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int { Section.allCases.count }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Section.allCases[section].rawValue.camelCaseToWords
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { Section.allCases[section].rowCount }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Section.allCases[indexPath.section].rowCount == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.identifier, for: indexPath) as! TextFieldCell
            let section = Section.allCases[indexPath.section]
            if section == .title {
                cell.textField.text = selectedTitleText
            } else if section == .message {
                cell.textField.text = selectedMessageText
            } else {
                cell.textField.text = selectedActionText
            }
            cell.section  = section
            cell.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = Color.allCases[indexPath.row].rawValue
        cell.selectionStyle = .none
        let section = Section.allCases[indexPath.section]
        if section == .backgroundColor {
            cell.accessoryType   = indexPath.row == selectedBackgroundColorIndex ? .checkmark : .none
        } else if section == .textColor {
            cell.accessoryType   = indexPath.row == selectedTextColorIndex ? .checkmark : .none
        }
        return cell
    }
}

extension ViewController: TextFieldCellDelegate {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = Section.allCases[indexPath.section]
        if section == .backgroundColor {
            selectedBackgroundColorIndex = indexPath.row
        } else if section == .textColor {
            selectedTextColorIndex = indexPath.row
        } else if section == .buttonTextColor {
            selectedButtonTextColorIndex = indexPath.row
        }
        tableView.reloadData()
    }

    func textFieldCell(_ textFieldCell: TextFieldCell, updatedText text: String?) {
        if textFieldCell.section == .title {
            selectedTitleText = text ?? ""
        } else if textFieldCell.section == .message {
            selectedMessageText = text ?? ""
        } else {
            selectedActionText = text ?? ""
        }
    }
}
