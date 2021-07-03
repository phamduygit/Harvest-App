//
//  StockRepository.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 03/07/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Combine

class StockRepository: ObservableObject {
    let db = Firestore.firestore()
    @Published var stocks = [Stock]()
    init () {
        let userId = Auth.auth().currentUser?.uid
        db.collection("stock").whereField("userId", isEqualTo: userId ?? "").addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.stocks = snapshot?.documents.compactMap {
                try? $0.data(as: Stock.self)
            } ?? []
        }
    }
    func addNewStock() -> Stock {
        do {
            let _ = try db.collection("stocks").addDocument(from: Stock()).collection("products").addDocument(from: Product())
        } catch {
            fatalError("Unable encode to user: \(error.localizedDescription)")
        }
        return Stock()
    }
}
