//
//  InStockView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 20/06/2021.
//

import SwiftUI

struct InStockView: View {
    @State private var products = [
        ItemInStock(id: 1, name: "Lúa Jasmine", image: "rice", totalWeight: 5000, offset: 0, isSwiped: false),
        ItemInStock(id: 2, name: "Lúa Jasmine", image: "rice", totalWeight: 5000, offset: 0, isSwiped: false),
        ItemInStock(id: 3, name: "Lúa Jasmine", image: "rice", totalWeight: 5000, offset: 0, isSwiped: false),
        ItemInStock(id: 4, name: "Lúa Jasmine", image: "rice", totalWeight: 5000, offset: 0, isSwiped: false),
    ]
    @State private var showDetailView : Bool = false
    @State private var listWeightOfSack = [Sack(id: 0, weight: 49.6), Sack(id: 1, weight: 49.6), Sack(id: 2, weight: 49.6), Sack(id: 3, weight: 49.6), Sack(id: 4, weight: 49.6)]
    var body: some View {
        
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 10) {
                    ForEach(products.indices) {index in
                        CardInStock(item: $products[index])
                            .cornerRadius(10)
                            .onTapGesture {
                                self.showDetailView.toggle()
                            }
                    }
                }
                .padding()
            }
            .background(Color("Color4").ignoresSafeArea())
            .fullScreenCover(isPresented: $showDetailView, content: {
                DetailInStockView(listWeightOfSack: $listWeightOfSack, show: $showDetailView)
            })
        }
    }
}

struct InStockView_Previews: PreviewProvider {
    static var previews: some View {
        InStockView()
    }
}
