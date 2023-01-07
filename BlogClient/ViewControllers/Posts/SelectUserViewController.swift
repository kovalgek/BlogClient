//
//  SelectUserViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 12/12/2021.
//

import UIKit

class SelectUserViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //tableView.refreshControl = refreshControl
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
    
    // MARK: - Properties
    var users: [User] = []
    var selectedUser: User

    // MARK: - Initializers
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented")
    }

    init(selectedUser: User) {
        self.selectedUser = selectedUser
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
      super.viewDidLoad()

        view.addSubview(tableView)
        setupTableViewLayouts(tableView)
        
      loadData()
    }

    func loadData() {
//      let usersRequest = ResourceRequest<User>(resourcePath: "users")
//
//      usersRequest.getAll { [weak self] result in
//        switch result {
//        case .failure:
//          let message = "There was an error getting the users"
//          ErrorPresenter.showError(message: message, on: self) { _ in
//            self?.navigationController?.popViewController(animated: true)
//          }
//        case .success(let users):
//          self?.users = users
//          DispatchQueue.main.async { [weak self] in
//            self?.tableView.reloadData()
//          }
//        }
//      }
    }

}

extension SelectUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        //let user = users[indexPath.row]
        selectedUser = users[indexPath.row]
        
        //let postViewController = PostViewController(postID: post.id)
        //navigationController?.pushViewController(postViewController, animated: true)
    }
}

extension SelectUserViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}
