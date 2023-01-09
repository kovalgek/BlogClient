//
//  PostsViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 05/12/2021.
//

import UIKit

class PostsViewController: UIViewController {

    private let service = POPPostService()
    private var posts: [Post] = []

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
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

        self.title = "Posts"

        view.addSubview(tableView)
        setupTableViewLayouts(tableView)
        
        let loginViewController = LoginViewController()
        navigationController?.present(loginViewController, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh(nil)
    }

    @objc private func goToCreatePost() {
        guard let navigationController = navigationController else {
            return
        }
        let createPostViewController = CreatePostViewController()
        navigationController.pushViewController(createPostViewController, animated: true)
    }


    @objc func refresh(_ sender: UIRefreshControl?) {

        Task(priority: .background) {
            let result = await service.posts()
            switch result {
            case .success(let posts):
                self.posts = posts
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        let post = posts[indexPath.row]
        let postViewController = PostViewController(post: post)
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

extension PostsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title
        return cell
    }
}
