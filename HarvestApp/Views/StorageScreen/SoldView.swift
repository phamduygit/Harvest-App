//
//  SoldView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 23/06/2021.
//

import SwiftUI

struct SoldView: View {
    @State private var showDetailView : Bool = false
    @State private var selectedProdcut : Product = Product()
    @State private var indexDelete : Int = -1
    @State private var showAlertDelete : Bool = false
    @EnvironmentObject var stockViewModel : StockViewModel
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 10) {
                    ForEach(stockViewModel.listSoldProduct()) {product in
                        CardInStock(product: product)
                            .cornerRadius(10)
                            .onTapGesture {
                                self.selectedProdcut = product
                                self.showDetailView.toggle()
                            }
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color("Color4").ignoresSafeArea())
            .fullScreenCover(isPresented: $showDetailView, content: {
                DetailInStockView(product: $selectedProdcut, show: $showDetailView)
            })
        }
    }
}

struct SoldView_Previews: PreviewProvider {
    static var previews: some View {
        SoldView()
    }
}
