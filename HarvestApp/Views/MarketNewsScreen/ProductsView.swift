//
//  ProductsView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 13/06/2021.
//

import SwiftUI

struct ProductsView: View {
    var listProduct = ["Lúa jasmine", "Lúa jasmine", "Lúa jasmine", "Lúa jasmine", "Lúa jasmine", "Lúa jasmine", "Lúa jasmine", "Lúa jasmine",]
    @State private var showDetail : Bool = false;
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ZStack {
                        Color("Color4").ignoresSafeArea()
                        VStack {
                            HStack {
                                Image("avatar")
                                    .resizable()
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .clipShape(Circle())
                                Spacer()
                                Button(action: {}, label: {
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .frame(width: 24, height: 24, alignment: .center)
                                        .foregroundColor(Color.black)
                                })
                                
                            }
                            .padding()
                            HStack {
                                Text("Bản tin thị trường")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            .padding(.horizontal)
                            VStack(spacing: 10) {
                                ForEach(listProduct.indices) {index in
                                    ItemCardView()
                                        .onTapGesture {
                                            withAnimation {
                                                self.showDetail.toggle()
                                            }
                                        }
                                }
                            }
                            .padding()
                            
                            Spacer()
                        }
                    }
                }
            }
            if showDetail {
                ProductDetailView(show: $showDetail)
            }
            
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
