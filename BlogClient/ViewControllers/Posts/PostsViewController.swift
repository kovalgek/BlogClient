//
//  PostsViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 05/12/2021.
//

import UIKit

class PostsViewController: UIViewController {

    init(viewModel: PostsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let viewModel: PostsViewModelProtocol    
    weak var coordinator: (LoginPresenting & PostShowing & PostCreating)?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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

        self.title = "Posts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createPost))

        view.addSubview(tableView)
        setupTableViewLayouts(tableView)
        
        coordinator?.presentLogin()
        
        setupBindings()
        viewModel.loadPosts()
    }
    
    private func setupBindings() {
        viewModel.posts.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func createPost() {
        coordinator?.createPost()
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
        tableView.deselectRow(at: indexPath, animated: true)
        let post = viewModel.posts.value[indexPath.row]
        coordinator?.showPost(postID: post.id)
    }
}

extension PostsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.posts.value[indexPath.row].title
        return cell
    }
}
