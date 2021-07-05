//
//  Category.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 05/07/2021.
//
import SwiftUI
import Foundation
import FirebaseFirestoreSwift

struct Category: Identifiable, Codable {
    @DocumentID var id : String?
    var categoryName : String = ""
    var image : String = ""
    var listProductName : [String] = []
    var type : String = ""
    var colorBackground : String = ""
    var offset : CGFloat = 0.0
}
