//
//  PostsViewController.swift
//  PostsApp
//
//  Created by Ostap Artym on 02.11.2023.
//

import UIKit

class PostsViewController: UIViewController {
    
    var expandedcell: IndexSet = []
    private var viewModel = PostsViewModel()
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .green
        table.register(PostsCell.self, forCellReuseIdentifier: PostsCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        setTableView()
    }
    
    func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
