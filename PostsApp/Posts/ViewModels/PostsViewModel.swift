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
    
    func numberOfRowsInSection(section: Int) -> Int {
        if allPosts.count != 0 {
            return allPosts.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Post {
        return allPosts[indexPath.row]
    }
    func sortByDate() {
        allPosts.sort { $0.timeshamp > $1.timeshamp }
    }
    
    func sortByRate() {
        allPosts.sort { $0.likesCount > $1.likesCount }
    }
}
