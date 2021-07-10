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
    @Published var users : [User] = []
    @Published var notifications: [Notification] = []
    init() {
        loadData()
    }
    func loadData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User id no exists!")
            return
        }
        db.collection("users").whereField("userId", isEqualTo: userId).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.users = snapshot?.documents.compactMap {
                try? $0.data(as: User.self)
            } ?? []
            print(self.users)
            if self.users.count == 1 {
                self.db.collection("users").document((self.users.first?.id)!).collection("notifications").addSnapshotListener { snapshotProduct, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    self.notifications = snapshotProduct?.documents.compactMap {
                        try? $0.data(as: Notification.self)
                    } ?? []
                    
                }
            }
        }
    }
    func addUser(_ user : User) {
        do {
            let _ = try db.collection("users").addDocument(from: user)
        } catch {
            fatalError("Unable encode to user: \(error.localizedDescription)")
        }
    }
    func updateUserInfo(user: User) {
        do {
            let _ = try db.collection("users").document(user.id!).setData(from: user)
        } catch {
            fatalError("Unable encode to user: \(error.localizedDescription)")
        }
    }
    func addNotification(notification: Notification, userID: String) {
        db.collection("users").whereField("userId", isEqualTo: userID).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            let tempUser = snapshot?.documents.compactMap {
                try? $0.data(as: User.self)
            } ?? []
            if self.users.count == 1 {
                do {
                    let _ = try self.db.collection("users").document((tempUser.first?.id)!).collection("notifications").addDocument(from: notification)
                } catch {
                    fatalError("Unable encode to stock: \(error.localizedDescription)")
                }
            }
        }
    }
}
