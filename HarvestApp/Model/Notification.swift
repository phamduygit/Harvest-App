//
//  Notification.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 09/07/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Notification : Identifiable, Codable{
    @DocumentID var id : String?
    var userID: String = ""
    var name: String = ""
    var avatar: String = ""
    var message: String = ""
    @ServerTimestamp var timeSend: Timestamp?
    var postID: String = ""
    var price: Float = 0
    var bookPrice: Float = 0
    var bookWeight: Float = 0
    var seem: Bool = false
    var email: String = ""
    var phone: String = ""
}
