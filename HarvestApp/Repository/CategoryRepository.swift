//
//  CategoryRepository.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 05/07/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class CategoryRepository : ObservableObject {
    let db = Firestore.firestore()
    @Published var categories: [Category] = []
    init() {
        db.collection("categories").addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.categories = snapshot?.documents.compactMap {
                try? $0.data(as: Category.self)
            } ?? []
        }
    }
}
