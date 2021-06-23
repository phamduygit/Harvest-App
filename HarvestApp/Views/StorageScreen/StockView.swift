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
    var tabs = ["Trong kho", "Đăng bán", "Đã bán"]
    var body: some View {
        VStack {
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
            .overlay(
                // Tab bar
                TabBarStock(offset: $offset, tabs: tabs)
                , alignment: .top)
        }
        .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(show: Binding.constant(false))
    }
}
