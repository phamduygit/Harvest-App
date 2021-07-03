//
//  StockViewModel.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 03/07/2021.
//

import Foundation
import FirebaseAuth
import Combine

class StockViewModel: ObservableObject {
    @Published var stock = Stock()
    @Published var stockRepository = StockRepository()
    private var cancellables : Set<AnyCancellable> = []
    init() {
        stockRepository.$stocks.map{ stocks in
            stocks.first { stock in
                stock.userID == Auth.auth().currentUser?.uid
            } ?? Stock()
        }
        .assign(to: \.stock, on: self)
        .store(in: &cancellables)
    }
    
    func addNewProduct(product: Product) {
        stockRepository.addNewProdctInStock(stockID: stock.id!, product: product)
    }
}
