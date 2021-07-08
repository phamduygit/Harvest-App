//
//  Post.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 07/07/2021.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
struct Post: Identifiable, Codable {
    @DocumentID var id : String?
    var avatar: String = ""
    var fullName: String = ""
    @ServerTimestamp var createdTime: Timestamp?
    var image: String = ""
    var productName: String = ""
    var category: String = ""
    var weight: Float = 0
    var price: Float = 0
    var description: String = ""
    var userID: String = ""
    var productID: String = ""
}
