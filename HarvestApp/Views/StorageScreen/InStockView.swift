//
//  InStockView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 20/06/2021.
//

import SwiftUI

struct InStockView: View {
    @State private var showDetailView : Bool = false
    @State private var indexDetail : Int = -1
    @State private var indexDelete : Int = -1
    @State private var showAlertDelete : Bool = false
    @EnvironmentObject var stockViewModel : StockViewModel
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 10) {
                    ForEach(stockViewModel.products) {product in
                        CardInStock(product: product)
                            .cornerRadius(10)
                            .onTapGesture {
                                self.indexDetail = getIndexInStock(product: product)
                                print("index \(indexDetail)")
                                self.showDetailView.toggle()
                            }
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color("Color4").ignoresSafeArea())
            .fullScreenCover(isPresented: $showDetailView, content: {
                DetailInStockView(indexDetail: $indexDetail, show: $showDetailView)
            })
        }
        
    }
    func getIndexInStock(product: Product) -> Int {
        let index = stockViewModel.products.firstIndex { item in
            item.id == product.id
        } ?? -1
        return index
    }
}


struct ItemInStock {
    var offset: CGFloat = 0
    var isSwiped: Bool = false
}
struct InStockView_Previews: PreviewProvider {
    static var previews: some View {
        InStockView()
    }
}
