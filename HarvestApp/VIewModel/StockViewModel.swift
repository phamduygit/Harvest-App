//
//  StockViewModel.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 03/07/2021.
//

import Foundation
import FirebaseAuth
import Combine
import SwiftUI

class StockViewModel: ObservableObject {
    @Published var stock = Stock()
    @Published var stockRepository = StockRepository()
    @Published var products = [Product]()
    private var cancellables : Set<AnyCancellable> = []
    init() {
        stockRepository.$stocks.map{ stocks in
            stocks.first { stock in
                stock.userID == Auth.auth().currentUser?.uid
            } ?? Stock()
        }
        .assign(to: \.stock, on: self)
        .store(in: &cancellables)
        stockRepository.$products
            .assign(to: \.products, on: self)
            .store(in: &cancellables)
    }
    
    func addNewProduct(image: UIImage, product: Product) {
        uploadImage(image: image) { url in
            var newProduct = product
            newProduct.image = url
            self.stockRepository.addNewProdctInStock(stockID: self.stock.id!, product: newProduct)
        }
    }
    func saveProduct(product: Product) {
        self.stockRepository.saveProductInStock(stockID: self.stock.id!, product: product)
    }
    func removeProduct(product: Product) {

        self.stockRepository.deleteProductInStock(stockID: self.stock.id!, product: product)
        stockRepository.$products
            .assign(to: \.products, on: self)
            .store(in: &cancellables)
    }
}
