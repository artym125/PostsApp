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
        table.backgroundColor = .white
        table.register(PostsCell.self, forCellReuseIdentifier: PostsCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = true
        return table
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "News"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setMainPage()
        loadPosts()
    }
    
    private func loadPosts() {
        viewModel.fetchAllPostsData { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setMainPage() {
        titleLabel.text = "News"
        navigationItem.titleView = titleLabel
        view.backgroundColor = .white
        setTableView()
        rightBarButton()
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
    private func rightBarButton() {
        let image = UIImage(named: "ArrowDown")?.withRenderingMode(.alwaysTemplate)
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.tintColor = .black

        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        barButton.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        barButton.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true

        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc private func sortButtonTapped() {
        
        if viewModel.shouldSortByLikesCount {
            viewModel.sortByRate()
        } else {
            viewModel.sortByDate()
        }
        viewModel.shouldSortByLikesCount.toggle()
        tableView.reloadData()
    }

}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostsCell.identifier, for: indexPath) as! PostsCell

        let post = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValueOf(post)
        cell.tableView = tableView
        
        if expandedcell.contains(indexPath.row) {
                    cell.subLabel.numberOfLines = 0
                    cell.expandButton.setTitle("Collapse", for: .normal)
                } else {
                    cell.subLabel.numberOfLines = 2
                }
                
        
        cell.butttonClicked = {
            if self.expandedcell.contains(indexPath.row) {
                self.expandedcell.remove(indexPath.row)
            }else {
                self.expandedcell.insert(indexPath.row)
            }
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)

        }
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.expandedcell.contains(indexPath.row) {
            self.expandedcell.remove(indexPath.row)
        }   else {
            self.expandedcell.insert(indexPath.row)
        }
        
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
}
