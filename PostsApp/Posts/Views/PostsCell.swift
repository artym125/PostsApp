//
//  PostsCell.swift
//  PostsApp
//
//  Created by Ostap Artym on 02.11.2023.
//

import UIKit

class PostsCell: UITableViewCell {
    
    static let identifier = "PostsCell"
    
    weak var tableView: UITableView?
    private var isExpanded = false
    
    var mainLabel: UILabel = UILabel()
    var subLabel: UILabel = UILabel()
    var likesCount: UILabel = UILabel()
    var dateCount: UILabel = UILabel()
    
    private lazy var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellViewTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var LikesAndDateStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    let expandButton: UIButton = {
        let button = UIButton()
        button.setTitle("Expand", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return button
    }()
    
    var butttonClicked: (() -> (Void))!
    @objc private func expandButtonTapped() {
        butttonClicked()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellView.backgroundColor = .white
        setLabels()
        setSubviews()
        setConstraints()
        expandButton.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLabel(fontSize: CGFloat, fontWeight: UIFont.Weight, textColor: UIColor?, numberOfLines: Int) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        label.textColor = textColor
        return label
    }
    
    func setLabels() {
        mainLabel = makeLabel(fontSize: 18, fontWeight: .semibold, textColor: .black, numberOfLines: 0)
        subLabel = makeLabel(fontSize: 16, fontWeight: .regular, textColor: UIColor(named: "subTitleColor"), numberOfLines: 2)
        likesCount = makeLabel(fontSize: 14, fontWeight: .regular, textColor: UIColor(named: "subTitleColor"), numberOfLines: 1)
        dateCount = makeLabel(fontSize: 14, fontWeight: .regular, textColor: UIColor(named: "subTitleColor"), numberOfLines: 1)
    }
    
    func setSubviews() {
        self.contentView.addSubview(cellView)
        
        cellView.addSubview(mainLabel)
        cellView.addSubview(subLabel)
        cellView.addSubview(LikesAndDateStackView)
        cellView.addSubview(expandButton)
        
        LikesAndDateStackView.addArrangedSubview(likesCount)
        LikesAndDateStackView.addArrangedSubview(dateCount)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            mainLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 18),
            mainLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 13),
            mainLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -13),
            
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 13),
            subLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 13),
            subLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -13),
            
            LikesAndDateStackView.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 13),
            LikesAndDateStackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 13),
            LikesAndDateStackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -13),
            
            expandButton.topAnchor.constraint(equalTo: LikesAndDateStackView.bottomAnchor, constant: 18),
            expandButton.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 0),
            expandButton.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 13),
            expandButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -13)
        ])
    }
    
    func updateUI(title: String?, previewText: String?, likesCount: Int?, timeshamp: Int?) {
        mainLabel.text = title
        subLabel.text = previewText
        self.likesCount.text = "♥️ "+String(likesCount ?? 0)
        dateCount.text = daysAgoFromTimestamp(timestamp: timeshamp ?? 0)
        
    }
    
    func setCellWithValueOf(_ post: Post) {
        updateUI(title: post.title, previewText: post.previewText, likesCount: post.likesCount, timeshamp: post.timeshamp)
    }
    
    func daysAgoFromTimestamp(timestamp: Int) -> String {
        let currentTime = Date().timeIntervalSince1970
        let timeDifference = TimeInterval(currentTime - TimeInterval(timestamp))
        
        let daysAgo = Int(timeDifference / 86400) // 86400 секунд у дні
        return "\(daysAgo) day ago"
    }
    
    @objc private func cellViewTapped() {
        // Отримати view controller, який містить поточний cell
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                // Отримати indexPath цього cell
                if (self.tableView?.indexPath(for: self)) != nil {
                    // Створити наступний view controller та передати дані з поточного cell
                    let nextViewController = DetailOfPostsViewController()
                    nextViewController.mainLabelText = mainLabel.text
                    nextViewController.subLabelText = subLabel.text
                    nextViewController.likesCountText = likesCount.text
                    nextViewController.dateCountText = dateCount.text
                    
                    // Виконати перехід на наступний view controller
                    viewController.navigationController?.pushViewController(nextViewController, animated: true)
                }
                break
            }
            responder = nextResponder
        }
    }
}
