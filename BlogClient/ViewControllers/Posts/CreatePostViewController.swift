//
//  CreatePostViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 11/12/2021.
//

import UIKit

class CreatePostViewController: UIViewController {

    private let postID: UUID
    private let viewModel: PostViewModel
    
    init(postID: UUID, viewModel: PostViewModel) {
        self.postID = postID
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

    private lazy var userLabel: UIButton = {
        let userLabel = UIButton()
        
        userLabel.setTitleColor(.black, for: .normal)
        userLabel.addTarget(self, action: #selector(goToSelectUser), for: .touchUpInside)
        return userLabel
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

    private func applyConstraints(userLabel: UIButton) {
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.topAnchor.constraint(equalTo: contentTextField.bottomAnchor, constant: 30).isActive = true
        userLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        userLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        userLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    enum PostControllerMode {
        case create
        case edit
    }

    private let post: Post?
    private var selectedUser: User?

    //private let mode: PostControllerMode

    init(post: Post? = nil) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Post"
        view.backgroundColor = .white

        view.addSubview(titleTextField)
        applyConstraints(titleTextField: titleTextField)

        view.addSubview(contentTextField)
        applyConstraints(contentTextField: contentTextField)

        view.addSubview(userLabel)
        applyConstraints(userLabel: userLabel)

        //acronymShortTextField.becomeFirstResponder()
        if let post = post {
            titleTextField.text = post.title
            contentTextField.text = post.content
            userLabel.setTitle(selectedUser?.name, for: .normal)
            navigationItem.title = "Edit Post"
        } else {
            populateUsers()
        }
    }

    @objc func goToSelectUser() {
        guard let navigationController = navigationController, let user = selectedUser else {
            return
        }
//        let selectUserViewController = SelectUserViewController(selectedUser: user)
//        navigationController.pushViewController(selectUserViewController, animated: true)
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
