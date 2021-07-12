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
    @Published var limitedPosts = [Post]()
    @Published var postRepository = PostRepository()
    private var cancellables : Set<AnyCancellable> = []
    init() {
        postRepository.$posts
            .assign(to: \.posts, on: self)
            .store(in: &cancellables)
        postRepository.$limitedPosts
            .assign(to: \.limitedPosts, on: self)
            .store(in: &cancellables)
    }
    func addPost(product: Product, userInfo: User, price: Float, totalWeight: Float, description: String) {
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
    func getOnePost(postID: String) -> Post {
        return posts.first { post in
            post.id == postID
        } ?? Post()
    }
    func filtered(category: String, bookmarks: [String], isMark: Bool) -> [Post] {
        let markedPost = posts.filter { post in
            bookmarks.contains(post.id!)
        }
        if category == "Tất cả" {
            if isMark {
                return markedPost
            } else {
                return posts
            }
            
        }
        if isMark {
            return markedPost.filter { post in
                post.category == category
            }
        } else {
            return posts.filter { post in
                post.category == category
            }
        }
    }
}
