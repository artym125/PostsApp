//
//  DetailOfPostsViewController.swift
//  PostsApp
//
//  Created by Ostap Artym on 02.11.2023.
//

import UIKit

class DetailOfPostsViewController: UIViewController {
    
    let postCl = PostsCell()
    
    var mainLabelText: String?
    var subLabelText: String?
    var likesCountText: String?
    var dateCountText: String?
    
    var mainLabel: UILabel = UILabel()
    var subLabel: UILabel = UILabel()
    var likesCount: UILabel = UILabel()
    var dateCount: UILabel = UILabel()
    
    private lazy var LikesAndDateStackView: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    let postImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "noImage")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel = postCl.makeLabel(fontSize: 18, fontWeight: .semibold, textColor: .black, numberOfLines: 0)
        subLabel = postCl.makeLabel(fontSize: 16, fontWeight: .regular, textColor: UIColor(named: "subTitleColor"), numberOfLines: 2)
        likesCount = postCl.makeLabel(fontSize: 14, fontWeight: .regular, textColor: UIColor(named: "subTitleColor"), numberOfLines: 1)
        dateCount = postCl.makeLabel(fontSize: 14, fontWeight: .regular, textColor: UIColor(named: "subTitleColor"), numberOfLines: 1)

        title = mainLabelText
        view.backgroundColor = .white

        setSubView()
        setConstraints()
    }
    
    func setSubView() {
        LikesAndDateStackView.addArrangedSubview(likesCount)
        LikesAndDateStackView.addArrangedSubview(dateCount)
        
        mainLabel.text = mainLabelText
        subLabel.text = subLabelText
        likesCount.text = likesCountText
        dateCount.text = dateCountText

        view.addSubview(postImage)
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        view.addSubview(LikesAndDateStackView)
    }
    
    func setConstraints() {

            NSLayoutConstraint.activate([
                postImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15 ),
                postImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                postImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                postImage.heightAnchor.constraint(equalToConstant: 300),
                
                mainLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 20),
                mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                
                subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 10),
                subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                subLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                
                LikesAndDateStackView.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 15),
                LikesAndDateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
                LikesAndDateStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13),
                
            ])
        }
}
