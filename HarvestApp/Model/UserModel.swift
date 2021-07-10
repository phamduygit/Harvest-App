//
//  UserModel.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 27/06/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id : String?
    var userId : String = ""
    var fullName: String = ""
    var email: String = ""
    var avatar : String = ""
    var phone: String = ""
    var bookmarks: [String] = []
    var favorite: [String] = []
}
