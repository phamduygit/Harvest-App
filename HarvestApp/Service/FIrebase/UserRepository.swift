//
//  UserRepository.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 30/06/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Combine

class UserRepository: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var usersInfo : [UserInfo] = []
    init() {
        loadData()
    }
    func loadData() {
        db.collection("users").addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.usersInfo = snapshot?.documents.compactMap {
                try? $0.data(as: UserInfo.self)
            } ?? []
        }
    }
    func addUser(_ user : UserInfo) {
        do {
            let _ = try db.collection("users").addDocument(from: user)
        } catch {
            fatalError("Unable encode to user: \(error.localizedDescription)")
        }
    }
    
    func printUser() {
        print("\n")
        for user in self.usersInfo {
            print("\(user)")
        }
    }
}
