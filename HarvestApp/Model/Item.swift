//
//  Item.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 10/07/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Item: Identifiable, Codable {
    @DocumentID var id: String?
    var image : String = ""
    var name: String = ""
    var category: String = ""
    var description: String = ""
    var price: Float = 0
    @ServerTimestamp var updateTime: Timestamp?
}
