//
//  PostViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 06/12/2021.
//

import UIKit

class PostViewController: UIViewController {

    var post: Post? {
        didSet {
            updatePostView()
        }
    }

    var user: User? {
        didSet {
            updatePostView()
        }
    }

    var categories: [Category] = [] {
        didSet {
            updatePostView()
        }
    }

    //private var post: Post

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private func setupTableViewLayouts(_ tableView: UITableView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Post"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(goToEditPost))

        view.addSubview(tableView)
        setupTableViewLayouts(tableView)
        
    }

    @objc private func goToEditPost() {
        guard let navigationController = navigationController else {
            return
        }
        let createPostViewController = CreatePostViewController(post: post)
        navigationController.pushViewController(createPostViewController, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getPostData()
    }

    func getPostData() {

//        guard let post = post else {
//            return
//        }
//
//        let postDetailRequester = PostRequest(postID: post.id!)
//        postDetailRequester.getUser { [weak self] result in
//            switch result {
//            case .success(let user):
//                self?.user = user
//            case .failure:
//                let message =
//                "There was an error getting the post’s user"
//                ErrorPresenter.showError(message: message, on: self)
//            }
//        }
//
//        postDetailRequester.getCategories { [weak self] result in
//            switch result {
//            case .success(let categories):
//                self?.categories = categories
//            case .failure:
//                let message =
//                "There was an error getting the post’s categories"
//                ErrorPresenter.showError(message: message, on: self)
//            }
//        }
    }

    func updatePostView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 3 ? categories.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = post?.title ?? ""
        case 1:
            cell.textLabel?.text = post?.content ?? ""
        case 2:
            cell.textLabel?.text = user?.name
        case 3:
            cell.textLabel?.text = categories[indexPath.row].name
        case 4:
            cell.textLabel?.text = "Add To Category"
        default:
            break
        }
        if indexPath.section == 4 {
            cell.selectionStyle = .default
            cell.isUserInteractionEnabled = true
        } else {
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Post"
        case 1:
            return "Meaning"
        case 2:
            return "User"
        case 3:
            return "Categories"
        default:
            return nil
        }
    }
}
