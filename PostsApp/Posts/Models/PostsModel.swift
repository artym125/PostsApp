//
//  PostsModel.swift
//  PostsApp
//
//  Created by Ostap Artym on 02.11.2023.
//

import Foundation

struct PostsModel: Codable {
    let posts: [Post]
 }

struct Post: Codable {
    let postID: Int
    let timeshamp: Int
    let title: String
    let previewText: String
    let likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}
