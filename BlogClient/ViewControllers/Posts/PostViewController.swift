//
//  PostViewController.swift
//  BlogClient
//
//  Created by Anton Kovalchuk on 06/12/2021.
//

import UIKit

class PostViewController: UIViewController {
    
    enum SectionType: Int {
        case title
        case content
        case user
    }

    private let postID: UUID
    private let viewModel: PostViewModel
    weak var coordinator: Popable?
    
    init(postID: UUID, viewModel: PostViewModel) {
        self.postID = postID
        self.viewModel = viewModel
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

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<- Posts", style: .plain, target: self, action: #selector(goBack))
        
        view.addSubview(tableView)
        setupTableViewLayouts(tableView)
        
        setupBindings()
        viewModel.loadPost(id: postID)
    }
    
    private func setupBindings() {
        viewModel.post.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @objc private func goBack() {
        coordinator?.goBack()
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        switch indexPath.section {
        case SectionType.title.rawValue:
            cell.textLabel?.text = viewModel.post.value?.title ?? ""
        case SectionType.content.rawValue:
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = viewModel.post.value?.content ?? ""
        case SectionType.user.rawValue:
            cell.textLabel?.text = viewModel.post.value?.user.id.description ?? ""
        default:
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case SectionType.title.rawValue:
            return "Post"
        case SectionType.content.rawValue:
            return "Meaning"
        case SectionType.user.rawValue:
            return "User"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case SectionType.title.rawValue:
            return 44
        case SectionType.content.rawValue:
            return 300
        case SectionType.user.rawValue:
            return 44
        default:
            return 44
        }
    }
}
