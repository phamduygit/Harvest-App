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
        stockRepository.$stocks.map {stocks in
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
    func addNewProduct(image: UIImage?, product: Product) {
        if image != nil {
            uploadImage(image: image!) { url in
                var newProduct = product
                newProduct.image = url
                self.stockRepository.addNewProdctInStock(stockID: self.stock.id!, product: newProduct)
            }
        } else {
            self.stockRepository.addNewProdctInStock(stockID: self.stock.id!, product: product)
        }
        
    }
    func postProdct(product: Product, totalWeight: Float) -> Product {
        var product1 : Product = product
        var product2 : Product = product
        product2.weight = []
        var sumWeight = totalWeight
        for index in 0..<product.weight.count {
            if (sumWeight > product.weight[index]) {
                sumWeight = sumWeight - product.weight[index]
                product1.weight.remove(at: 0)
                product2.weight.append(product.weight[index])
            } else {
                product1.weight[0] = product.weight[index] - sumWeight
                product2.weight.append(sumWeight)
                sumWeight = 0
            }
            if sumWeight == 0 {
                break
            }
        }
        product1.status = 1
        product2.status = 2
        saveProduct(product: product1)
        let productID = self.stockRepository.addProduct(stockID: self.stock.id!, product: product2)
        product2.id = productID
        return product2
    }
    func saveProduct(product: Product) {
        self.stockRepository.saveProductInStock(stockID: self.stock.id!, product: product)
    }
    func saveProductAndImage(image: UIImage?, product: Product) {
        if image != nil {
            uploadImage(image: image!) { url in
                var newProduct = product
                newProduct.image = url
                self.stockRepository.saveProductInStock(stockID: self.stock.id!, product: newProduct)
            }
        } else {
            self.stockRepository.saveProductInStock(stockID: self.stock.id!, product: product)
        }
    }
    func removeProduct(product: Product) {
        self.stockRepository.deleteProductInStock(stockID: self.stock.id!, product: product)
        stockRepository.$products
            .assign(to: \.products, on: self)
            .store(in: &cancellables)
    }
    func listProductInStock() -> [Product] {
        return self.products.filter { products in
            products.status == 1
        }
    }
    func listSoldProduct() -> [Product] {
        return self.products.filter { products in
            products.status == 3
        }
    }
}
