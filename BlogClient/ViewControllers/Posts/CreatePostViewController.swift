//
//  CreatePostViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 11/12/2021.
//

import UIKit

class CreatePostViewController: UIViewController {

    private let viewModel: CreatePostViewModel
    weak var coordinator: Dismissable?
    
    init(viewModel: CreatePostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    private lazy var titleTextField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.placeholder = "Enter title here"
        titleTextField.backgroundColor = .lightGray
        return titleTextField
    }()

    private lazy var contentTextField: UITextField = {
        let contentTextField = UITextField()
        contentTextField.placeholder = "Enter content here"
        contentTextField.backgroundColor = .lightGray
        return contentTextField
    }()
    
    private lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
        return saveButton
    }()

    private func applyConstraints(titleTextField: UITextField) {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    private func applyConstraints(contentTextField: UITextField) {
        contentTextField.translatesAutoresizingMaskIntoConstraints = false
        contentTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30).isActive = true
        contentTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        contentTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func applyConstraints(saveButton: UIButton) {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: contentTextField.bottomAnchor, constant: 30).isActive = true
        saveButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Post"
        view.backgroundColor = .white
        // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(createPost))

        view.addSubview(titleTextField)
        applyConstraints(titleTextField: titleTextField)

        view.addSubview(contentTextField)
        applyConstraints(contentTextField: contentTextField)
        
        view.addSubview(saveButton)
        applyConstraints(saveButton: saveButton)
    }

    @objc private func createPost() {
//        guard let navigationController = navigationController, let user = selectedUser else {
//            return
//        }
//        let selectUserViewController = SelectUserViewController(selectedUser: user)
//        navigationController.pushViewController(selectUserViewController, animated: true)
        
        viewModel.createPost(title: titleTextField.text ?? "",
                             content: contentTextField.text ?? "",
                             userID: Auth.userID!)
    }

    func populateUsers() {
//        let usersRequest = ResourceRequest<User>(resourcePath: "users")
//
//        usersRequest.getAll { [weak self] result in
//            switch result {
//            case .failure:
//                let message = "There was an error getting the users"
//                ErrorPresenter.showError(message: message, on: self) { _ in
//                    self?.navigationController?.popViewController(animated: true)
//                }
//            case .success(let users):
//                DispatchQueue.main.async { [weak self] in
//                    self?.userLabel.setTitle(users[0].name, for: .normal)
//                }
//                self?.selectedUser = users[0]
//            }
//        }
    }

}
