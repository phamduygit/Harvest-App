//
//  ItemRepository.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 10/07/2021.
//

import Foundation
import FirebaseFirestore


class ItemRepository: ObservableObject {
    @Published var items: [Item] = []
    let db = Firestore.firestore()
    init() {
        db.collection("items").addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.items = snapshot?.documents.compactMap {
                try? $0.data(as: Item.self)
            } ?? []
        }
    }
    
    
}
