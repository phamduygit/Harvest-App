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
    @Published var userInfo : UserInfo = UserInfo()
    @Published var isLogin : Bool = false
    @Published var userRepository = UserRepository()
    private var cancellables : Set<AnyCancellable> = []
    init() {
        self.loadUserInfo()
    }
    func loadUserInfo () {
        self.isLogin = Auth.auth().currentUser != nil ? true : false
        if isLogin {
            userRepository.$usersInfo.map{ users in
                users.first { user in
                    user.userId == Auth.auth().currentUser?.uid
                } ?? UserInfo()
            }
            .assign(to: \.userInfo, on: self)
            .store(in: &cancellables)
        }
    }
    func addUser(avatar: UIImage, userInfo: UserInfo, password: String) {
        var user = userInfo
        let userId : String = createAccount(email: user.email, password: password)
        print(userId)
        uploadImage(image: avatar) { [self] (url) in
            updateProfile(photoURL: url, fullName: user.fullName)
            user.avatar = url
            user.userId = userId
            self.isLogin = true
            self.userInfo = user
            userRepository.addUser(user)
        }
    }
    func logIn(email: String, password: String) {
        signIn(email: email, password: password)
        loadUserInfo()
        
    }
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}
