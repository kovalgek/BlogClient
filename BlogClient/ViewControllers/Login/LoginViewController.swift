//
//  LoginViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 08/01/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let viewModel: LoginViewModelProtocol
    weak var coordinator: LoginCoordinator?
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your login"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        // button.backgroundColor = .systemIndigo
        button.setTitle("Log In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    private let loginService = POPLoginService()
    
    @objc func login() {
        guard let username = loginTextField.text, let password = passwordTextField.text else {
            return
        }
        Task(priority: .background) {
            let result = await loginService.login(username: "admin", password: "password")
            switch result {
            case .success:
                self.coordinator?.backToPosts()
            case .failure:
                print("error")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Login"
        self.view.backgroundColor = .white
        
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)

        setupLayoutconstrains()
    }
    
    private func setupLayoutconstrains() {
        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}

