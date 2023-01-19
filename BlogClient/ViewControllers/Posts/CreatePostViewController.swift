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

        view.addSubview(titleTextField)
        applyConstraints(titleTextField: titleTextField)

        view.addSubview(contentTextField)
        applyConstraints(contentTextField: contentTextField)
        
        view.addSubview(saveButton)
        applyConstraints(saveButton: saveButton)
    }

    @objc private func createPost() {
        
        guard let title = titleTextField.text, let content = contentTextField.text else {
            return
        }
        
        viewModel.createPost(title: title, content: content) { error in
            DispatchQueue.main.async {
                self.coordinator?.dimiss(viewController: self)
            }
        }
    }
}
