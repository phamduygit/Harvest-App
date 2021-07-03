//
//  Stock.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 03/07/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Stock: Identifiable, Codable {
    @DocumentID var id: String?
    var product : [Product] = []
    var userID : String = ""
}
