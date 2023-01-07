//
//  CreateCategoryViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 12/12/2021.
//

import UIKit

class CreateCategoryViewController: UIViewController {

    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "Enter name here"
        nameTextField.backgroundColor = .lightGray
        return nameTextField
    }()

    private func applyConstraints(_ nameTextField: UITextField) {

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Category"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveCategory))

        nameTextField.becomeFirstResponder()
        view.addSubview(nameTextField)
        applyConstraints(nameTextField)
    }

    @objc private func saveCategory() {

//        guard let name = nameTextField.text, !name.isEmpty else {
//            ErrorPresenter.showError(message: "You must specify a name", on: self)
//            return
//        }
//
//        let category = Category(name: name)
//        ResourceRequest<Category>(resourcePath: "categories").save(category) { [weak self] result in
//            switch result {
//            case .failure:
//                let message = "There was a problem saving the category"
//                ErrorPresenter.showError(message: message, on: self)
//            case .success:
//                DispatchQueue.main.async { [weak self] in
//                    guard let self = self, let navigationController = self.navigationController else {
//                        return
//                    }
//                    navigationController.popViewController(animated: true)
//                }
//            }
//        }
    }
}
