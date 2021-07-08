//
//  PostViewModel.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 07/07/2021.
//

import Foundation
import Combine
import FirebaseAuth

class PostViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var postRepository = PostRepository()
    private var cancellables : Set<AnyCancellable> = []
    init() {
        postRepository.$posts
            .assign(to: \.posts, on: self)
            .store(in: &cancellables)
    }
    func addPost(product: Product, userInfo: UserInfo, price: Float, totalWeight: Float, description: String) {
        var post = Post()
        post.avatar = userInfo.avatar
        post.fullName = userInfo.fullName
        post.weight = totalWeight
        post.price = price
        post.image = product.image
        post.productName = product.name
        post.category = product.category
        post.description = description
        post.userID = userInfo.userId
        post.productID = product.id!
        postRepository.addPost(post: post)
    }
    
    func listPostInStock() -> [Post] {
        return self.posts.filter { post in
            post.userID == Auth.auth().currentUser?.uid
        }
    }
    func updatePost(post: Post) {
        postRepository.updatePost(post: post)
    }
    func deletePost(post: Post) {
        postRepository.deletePost(post: post)
    }
    func filtered(category: String) -> [Post] {
        if category == "Tất cả" {
            return posts
        }
        return posts.filter { post in
            post.category == category
        }
    }
}
