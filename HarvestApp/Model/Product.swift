//
//  Product.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 03/07/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Product: Identifiable, Codable {
    @DocumentID var id : String?
    var name: String = ""
    var category: String = ""
    var weight: [Float] = []
    @ServerTimestamp var timeHarvest : Timestamp?
}
