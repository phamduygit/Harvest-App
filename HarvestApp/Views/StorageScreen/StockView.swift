//
//  StockView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 22/06/2021.
//

import SwiftUI

struct StockView: View {
    @Binding var show: Bool
    @State private var offset : CGFloat = 0
    @State private var showDetailInStock: Bool = false
    var tabs = ["Trong kho", "Đăng bán", "Đã bán"]
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                HStack {
                    Button(action: {
                        self.show.toggle()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.black)
                    })
                    Spacer()
                }
                .padding()
                Text("Kho")
                    .font(.title2)
                    .fontWeight(.medium)
            }
            TabBarStock(offset: $offset, tabs: tabs)
            GeometryReader{geomentry in
                let rect = geomentry.frame(in: .global)
                ScrollTableTabBar(tabs: tabs, rect: rect, offset: $offset) {
                    HStack {
                        InStockView()
                            .frame(width: rect.width)
                        PostingView()
                            .frame(width: rect.width)
                        SoldView()
                            .frame(width: rect.width)
                    }
                }
                
            }
            
        }
        .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(show: Binding.constant(false))
    }
}
