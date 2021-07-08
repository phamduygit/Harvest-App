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
    @Published var products = [Product]()
    init () {
        let userId = Auth.auth().currentUser?.uid
        db.collection("stocks").whereField("userID", isEqualTo: userId!).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.stocks = snapshot?.documents.compactMap {
                try? $0.data(as: Stock.self)
            } ?? []
            print("ahihi \(self.stocks.count)")
            if self.stocks.count < 1 {
                self.stocks.append(self.addNewStock())
            } else {
                self.db.collection("stocks").document((self.stocks.first?.id)!).collection("products").addSnapshotListener { snapshotProduct, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    self.products = snapshotProduct?.documents.compactMap {
                        try? $0.data(as: Product.self)
                    } ?? []
                    
                }
            }
            
        }
    }
    func addNewStock() -> Stock {
        var stock = Stock()
        stock.userID = Auth.auth().currentUser!.uid
        do {
            let _ = try db.collection("stocks").addDocument(from: stock)
        } catch {
            fatalError("Unable encode to stock: \(error.localizedDescription)")
        }
        return Stock()
    }
    func addNewProdctInStock(stockID: String, product: Product) {
        do {
            let _ = try db.collection("stocks").document(stockID).collection("products").addDocument(from: product)
        } catch {
            fatalError("Unable encode to stock: \(error.localizedDescription)")
        }
    }
    func addProduct(stockID: String, product: Product) -> String {
        var ref: DocumentReference? = nil
        do {
            ref = try db.collection("stocks").document(stockID).collection("products").addDocument(from: product)
        } catch {
            fatalError("Unable encode to stock: \(error.localizedDescription)")
        }
        return ref!.documentID
    }
    func saveProductInStock(stockID: String, product: Product) {
        do {
            let _ = try db.collection("stocks").document(stockID).collection("products").document(product.id!).setData(from: product)
        } catch {
            fatalError("Unable encode to stock: \(error.localizedDescription)")
        }
    }
    func deleteProductInStock(stockID: String, product: Product) {
        db.collection("stocks").document(stockID).collection("products").document(product.id!).delete()  { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
