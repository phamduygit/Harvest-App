//
//  PostRepository.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 07/07/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PostRepository: ObservableObject {
    @Published var posts = [Post]()
    let db = Firestore.firestore()
    init() {
        db.collection("posts").order(by: "createdTime").addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.posts = snapshot?.documents.compactMap {
                try? $0.data(as: Post.self)
            } ?? []
        }
    }
    func addPost(post: Post) {
        do {
           let _ = try db.collection("posts").addDocument(from: post)
        }
        catch {
            fatalError("ERROR: \(error.localizedDescription)")
        }
    }
    func updatePost(post: Post) {
        do {
            let _ = try db.collection("posts").document(post.id!).setData(from: post)
        }
        catch {
            fatalError("ERROR: \(error.localizedDescription)")
        }
    }
    func deletePost(post: Post) {
        db.collection("posts").document(post.id!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
