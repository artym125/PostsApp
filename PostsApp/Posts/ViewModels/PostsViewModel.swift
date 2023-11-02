//
//  PostsViewModel.swift
//  PostsApp
//
//  Created by Ostap Artym on 02.11.2023.
//

import Foundation

class PostsViewModel {
    var apiService = ApiService()
    var allPosts = [Post]()
    var shouldSortByLikesCount = false
    
    
    func fetchAllPostsData(completion: @escaping () -> ()) {
        apiService.getPosts { [weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.allPosts = listOf.posts
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
}
