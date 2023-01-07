//
//  CategoriesViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 05/12/2021.
//

import UIKit

class CategoriesViewController: UIViewController {

    private var categories: [Category] = []
    // private let categoriesRequest = ResourceRequest<Category>(resourcePath: "categories")

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

        self.title = "Categories"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToCreateCategories))

        view.addSubview(tableView)
        setupTableViewLayouts(tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh(nil)
    }

    @objc private func goToCreateCategories() {
        guard let navigationController = navigationController else {
            return
        }
        let createCategoryViewController = CreateCategoryViewController()
        navigationController.pushViewController(createCategoryViewController, animated: true)
    }

    @objc func refresh(_ sender: UIRefreshControl?) {

//        categoriesRequest.getAll { [weak self] categoryResult in
//            DispatchQueue.main.async {
//                sender?.endRefreshing()
//            }
//
//            switch categoryResult {
//            case .failure:
//                ErrorPresenter.showError(
//                    message: "There was an error getting the posts",
//                    on: self)
//            case .success(let categories):
//                DispatchQueue.main.async { [weak self] in
//                    guard let self = self else { return }
//                    self.categories = categories
//                    self.tableView.reloadData()
//                }
//            }
//        }
    }
}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        let category = categories[indexPath.row]
        //let postViewController = PostViewController(postID: post.id)
        //navigationController?.pushViewController(postViewController, animated: true)
    }
}

extension CategoriesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
}


