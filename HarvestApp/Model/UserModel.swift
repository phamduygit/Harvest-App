//
//  UserModel.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 27/06/2021.
//

import Foundation

struct User: Identifiable {
    var id : String
    var fullName: String
    var email: String
    var avatar : String
    var phone: String
}
