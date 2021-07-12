//
//  ProductsView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 13/06/2021.
//

import SwiftUI

struct ProductsView: View {
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
    @Binding var showTabBar : Bool
    @EnvironmentObject var itemViewModel : ItemViewModel
    @EnvironmentObject var userViewModel : UserViewModel
    @State private var selectedItem = Item()
    @State private var selectedDate: Date = Date()
    var body: some View {
        ZStack {
            VStack(spacing: 5) {
//                HStack {
//                    HStack {
//                        TextField("Tìm kiếm nông sản", text: $key)
//                        Spacer()
//                        Image(systemName: "magnifyingglass")
//                    }
//                    .padding(10)
//                    .background(Color.white)
//                    .cornerRadius(10)
//
//                }
//                .padding()
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
                DatePicker("Ngày cập nhật", selection: $selectedDate, displayedComponents: [.date])
                    .padding(.horizontal)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(itemViewModel.listItemFiltered(category: filter.rawValue, favorites: userViewModel.user.favorite, isFavorite: showFavoritesOnly, updateDate: selectedDate)) {item in
                            ItemCardView(item: item)
                                .onTapGesture {
                                    selectedItem = item
                                    showDetail.toggle()
                                }
                        }
                    }
                    .padding()
                    .padding(.bottom, 60)
                    
                }
            }
            
            .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
        }
        .fullScreenCover(isPresented: $showDetail, content: {
            ProductDetailView(show: $showDetail, selectedItem: $selectedItem)
        })
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(showTabBar: Binding.constant(true))
    }
}
