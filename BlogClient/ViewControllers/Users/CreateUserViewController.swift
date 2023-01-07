//
//  CreateUserViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 12/12/2021.
//

import UIKit

class CreateUserViewController: UIViewController {

    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "Enter name here"
        nameTextField.backgroundColor = .lightGray
        return nameTextField
    }()

    private lazy var usernameTextField: UITextField = {
        let usernameTextField = UITextField()
        usernameTextField.placeholder = "Enter username here"
        usernameTextField.backgroundColor = .lightGray
        return usernameTextField
    }()

    private func applyConstraints(_ nameTextField: UITextField) {

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    private func applyConstraints(usernameTextField: UITextField) {

        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30).isActive = true
        usernameTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        usernameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create User"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveUser))

        nameTextField.becomeFirstResponder()

        view.addSubview(nameTextField)
        applyConstraints(nameTextField)

        view.addSubview(usernameTextField)
        applyConstraints(usernameTextField: usernameTextField)
    }
    

    @objc private func saveUser() {

//        guard let name = nameTextField.text, !name.isEmpty else {
//            ErrorPresenter.showError(message: "You must specify a name", on: self)
//            return
//        }
//
//        guard let username = usernameTextField.text, !username.isEmpty else {
//            ErrorPresenter.showError(message: "You must specify a username", on: self)
//            return
//        }
//
//        let user = User(name: name, username: username)
//        ResourceRequest<User>(resourcePath: "users").save(user) { [weak self] result in
//            switch result {
//            case .failure:
//                let message = "There was a problem saving the user"
//                ErrorPresenter.showError(message: message, on: self)
//            case .success:
//                DispatchQueue.main.async { [weak self] in
//                    self?.navigationController?
//                        .popViewController(animated: true)
//                }
//            }
//        }
    }

}
