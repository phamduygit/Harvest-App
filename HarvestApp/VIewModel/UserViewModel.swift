//
//  UserViewModel.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 29/06/2021.
//

import Foundation
import Combine
import SwiftUI
import FirebaseAuth

class UserViewModel : ObservableObject {
    @Published var user : User = User()
    @Published var isLogin : Bool = false
    @Published var userRepository = UserRepository()
    @Published var isError : Bool = false
    @Published var errorDescription : String = ""
    @Published var notifications: [Notification] = []
    private var cancellables : Set<AnyCancellable> = []
    init() {
        self.loadUserInfo()
    }
    func loadUserInfo() {
        self.isLogin = Auth.auth().currentUser != nil ? true : false
        if isLogin {
            userRepository.$users.map{ users in
                users.first { user in
                    user.userId == Auth.auth().currentUser?.uid
                } ?? User()
            }
            .assign(to: \.user, on: self)
            .store(in: &cancellables)
            userRepository.$notifications
            .assign(to: \.notifications, on: self)
            .store(in: &cancellables)
        }
    }
    func addUser(avatar: UIImage, userInfo: User, password: String) {
        var user = userInfo
        Auth.auth().createUser(withEmail: userInfo.email, password: password) { data, err in
            if err != nil {
                self.isError = true
                self.errorDescription = err?.localizedDescription ?? ""
                return
            }
            let userId = Auth.auth().currentUser?.uid ?? "none"
            uploadImage(image: avatar) { [self] (url) in
                updateProfile(photoURL: url, fullName: user.fullName)
                user.avatar = url
                user.userId = userId
                self.isLogin = true
                self.user = user
                userRepository.addUser(user)
            }
        }
    }
    func updateUserInfo(avatar: UIImage?, userInfo: User) {
        if Auth.auth().currentUser == nil {
            return
        }
        var user = userInfo
        if avatar != nil {
            uploadImage(image: avatar!) { [self] (url) in
                updateProfile(photoURL: url, fullName: userInfo.fullName)
                user.avatar = url
                userRepository.updateUserInfo(user: user)
            }
        } else {
            updateProfile(photoURL: userInfo.avatar, fullName: userInfo.fullName)
            userRepository.updateUserInfo(user: user)
        }
    }
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { data, error in
            if error != nil {
                self.isError = true
                self.errorDescription = error?.localizedDescription ?? ""
                return
            }
            self.userRepository.loadData()
            self.loadUserInfo()
        }
    }
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    func forgotPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
        }
    }
    func saveUser(user: User) {
        userRepository.updateUserInfo(user: user)
    }
    func addBookmark(postID: String) {
        user.bookmarks.append(postID)
        saveUser(user: user)
    }
    func removeBookmark(postID: String) {
        guard let index = user.bookmarks.firstIndex(of: postID) else { return }
        user.bookmarks.remove(at: index)
        saveUser(user: user)
    }
    func addNotification(notification: Notification, userID: String) {
        userRepository.addNotification(notification: notification, userID: userID)
    }
    func addFavorite(itemID: String) {
        user.favorite.append(itemID)
        saveUser(user: user)
    }
    func removeFavorite(itemID: String) {
        guard let index = user.favorite.firstIndex(of: itemID) else { return }
        user.favorite.remove(at: index)
        saveUser(user: user)
    }
}
