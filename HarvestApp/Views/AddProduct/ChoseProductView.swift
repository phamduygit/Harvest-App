//
//  ChoseProductView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 15/06/2021.
//

import SwiftUI

struct ChoseProductView: View {
    @StateObject var productViewModel = ProductViewModel()
    @EnvironmentObject var categoryViewModel : CategoryViewModel
    @State private var listProductName = [String]()
    @State private var scrolled = 0
    @State private var selected : String = "Lúa Jasmine"
    @State private var showNames : Bool = false
    @State private var showInputWeight : Bool = false
    @Binding var showAddProdct : Bool
    @State private var showAlert : Bool = false
    @State private var type = "bao"
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    HStack {
                        Button(action: {
                            self.showAddProdct.toggle()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.black)
                        })
                        Spacer()
                    }
                    .padding()
                    Text("Thu hoạch")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Chọn nông sản")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.horizontal)
                        ZStack {
                            ForEach(categoryViewModel.categories.reversed()) { category in
                                CategoryCard(index: getIndexOfCategory(category: category), scrolled: $scrolled, listProductName: $listProductName)
                                    .environmentObject(categoryViewModel)
                                    .environmentObject(productViewModel)
                                //                                Text(category.categoryName)
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height / 2)
                        .padding(.horizontal)
                        .padding(.top)
                        if productViewModel.product.category != "" {
                            Button(action: {
                                showNames.toggle()
                            }, label: {
                                HStack {
                                    Text("Tên nông sản")
                                    Spacer()
                                    Text(productViewModel.product.name)
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .foregroundColor(Color.black)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                .padding()
                            })
                        }
                        
                        Button(action: {
                            if productViewModel.product.category !=  "" {
                                self.showInputWeight.toggle()
                            }
                            else {
                                self.showAlert.toggle()
                            }
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Nhập sản lượng")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                Spacer()
                            }
                            .padding()
                            .background(Color("Color5"))
                            .clipShape(Capsule())
                            .padding()
                            .padding(.bottom)
                            
                        })
                    }
                }
            }
            .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Chưa chọn loại nông sản"), message: Text("Hãy chọn loại nông sản bạn muốn thu hoạch"), dismissButton: .default(Text("OK")))
            })
            if showNames {
                NameOfProductView(show: $showNames, selected: $productViewModel.product.name, categoryName: $productViewModel.product.category)
                    .environmentObject(productViewModel)
            }
            if showInputWeight {
                ListWeightView(showInputWeigth: $showInputWeight, showAddProdct: $showAddProdct)
                    .environmentObject(productViewModel)
            }
        }
    }
    func getIndexOfCategory(category: Category) -> Int {
        let index = categoryViewModel.categories.firstIndex { cate in
            cate.id == category.id
        }
        return index ?? -1
    }
}

struct ChoseProductView_Previews: PreviewProvider {
    static var previews: some View {
        ChoseProductView(showAddProdct: Binding.constant(false))
    }
}

struct CarđData : Identifiable{
    var id : Int
    var image : String = ""
    var color : Color
    var title : String = ""
    var offset: CGFloat
}
