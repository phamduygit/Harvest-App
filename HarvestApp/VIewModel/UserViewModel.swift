//
//  UserViewModel.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 29/06/2021.
//

import Foundation

class UserViewModel : ObservableObject {
    @Published var user : User
    @Published var isLogin : Bool
    init(user : User, isLogin: Bool) {
        self.user = user
        self.isLogin = isLogin
    }
    
}
