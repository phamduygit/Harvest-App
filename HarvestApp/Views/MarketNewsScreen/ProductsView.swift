//
//  ProductsView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 13/06/2021.
//

import SwiftUI

struct ProductsView: View {
    var listProduct = ["Lúa jasmine", "Lúa jasmine", "Lúa jasmine", "Lúa jasmine", "Lúa jasmine", "Lúa jasmine", "Lúa jasmine", "Lúa jasmine",]
    @State private var filter = FilterCategory.all
    enum FilterCategory: String, CaseIterable, Identifiable {
        case all = "Tất cả"
        case rice = "Lúa"
        case coffee = "Cà phê"
        case blackPepper = "Tiêu"
        var id: FilterCategory { self }
    }
    @State private var showFavoritesOnly = false
    @State private var showDetail : Bool = false
    @State private var key : String = ""
    @Binding var showTabBar : Bool
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    HStack {
                        TextField("Tìm kiếm nông sản", text: $key)
                        Spacer()
                        Image(systemName: "magnifyingglass")
//                            .resizable()
//                            .frame(width: 24, height: 24, alignment: .center)
                            
                    }
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                }
                .padding()
                HStack {
                    Text("Bản tin thị trường")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Menu {
                        Picker(selection: $filter, label: Text("Picker"), content: {
                            ForEach(FilterCategory.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        })
                        Toggle(isOn: $showFavoritesOnly) {
                            Label("Đã yêu thích", systemImage: "heart.fill")
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(Color.black)
                    }

                }
                .padding(.horizontal)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(listProduct.indices) {index in
                            ItemCardView()
                                .onTapGesture {
                                    self.showDetail.toggle()
                                    self.showTabBar.toggle()
                                }
                        }
                    }
                    .padding()
                    
                }
            }
            .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
            if showDetail {
                ProductDetailView(show: $showDetail, showTabBar: $showTabBar)
            }
            
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(showTabBar: Binding.constant(true))
    }
}
