//
//  PostsViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 05/12/2021.
//

import UIKit

class PostsViewController: UIViewController {

    private var posts: [Post] = []
    // private let postsRequest = ResourceRequest<Post>(resourcePath: "posts")

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

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToCreatePost))

        view.addSubview(tableView)
        setupTableViewLayouts(tableView)
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

    let service = POPPostService()

    @objc func refresh(_ sender: UIRefreshControl?) {

//        let transport = Transport()
//        let parser = PostParser()
//        let postService = PostService(transport: transport, parser: parser)
//        
//        postService.loadPosts { posts in
//            self.posts = posts
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.reloadData()
//            }
//        }
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
        

//        postsRequest.getAll { [weak self] postResult in
//            DispatchQueue.main.async {
//                sender?.endRefreshing()
//            }
//
//            switch postResult {
//            case .failure:
//                ErrorPresenter.showError(
//                    message: "There was an error getting the posts",
//                    on: self)
//            case .success(let posts):
//                DispatchQueue.main.async { [weak self] in
//                    guard let self = self else { return }
//                    self.posts = posts
//                    self.tableView.reloadData()
//                }
//            }
//        }
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
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title
        return cell
    }
}
