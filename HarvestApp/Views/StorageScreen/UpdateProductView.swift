//
//  UpdateProductView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 04/07/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct UpdateProductView: View {
    @State private var showNames : Bool = false
    @State private var showInputWeight : Bool = false
    @State private var ricesCategory = ["Lúa Jasmine", "Lúa IR 50404", "Lúa OM 9577", "Lúa OM 9582"]
    @State private var selected : String = "Lúa Jasmine"
    @State private var listProdcutName = [String]()
    @Binding var indexDetail : Int
    @Binding var show : Bool
    
    @EnvironmentObject var stockViewModel : StockViewModel
    var body: some View {
        ZStack {
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
                    .padding(.horizontal)
                    Text("Kho")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Cập nhật nông sản")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.horizontal)
                        ZStack {
                            AnimatedImage(url: URL(string: stockViewModel.products[indexDetail].image))
                                .resizable()
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fit)
                                
                        }
                        .padding()
                        .frame(height: UIScreen.main.bounds.height / 3)
                        Button(action: {
                            showNames.toggle()
                        }, label: {
                            HStack {
                                Text("Tên nông sản")
                                Spacer()
                                Text(stockViewModel.products[indexDetail].name)
                                Image(systemName: "chevron.right")
                                
                            }
                            .onAppear {
                                self.selected = stockViewModel.products[indexDetail].name
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                        })
                        .padding(.horizontal)
                        .padding(.bottom)
                        Button(action: {
                            showInputWeight.toggle()
                        }, label: {
                            HStack {
                                Text("Tổng sản lượng")
                                Spacer()
                                Text("\(stockViewModel.products[indexDetail].weight.reduce(0, +), specifier: "%.2f") kg")
                                Image(systemName: "chevron.right")
                                
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                        })
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                    }
                }
                
            }
            .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
            .overlay(
                HStack {
                    Button(action: {
                        stockViewModel.saveProduct(product: stockViewModel.products[indexDetail])
                        self.show.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Lưu")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.yellow)
                        .clipShape(Capsule())
                        .padding()
                        .padding(.bottom)
                        
                    })
                }
                , alignment: .bottom
            )
            if showNames {
                NameOfProductView(show: $showNames, selected: $stockViewModel.products[indexDetail].name, categoryName: $stockViewModel.products[indexDetail].category)
            }
            if showInputWeight {
                UpdateListWeightView(show: $showInputWeight, product: $stockViewModel.products[indexDetail])
            }
        }
    }
}

struct UpdateProductView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProductView(indexDetail: Binding.constant(0), show: Binding.constant(false))
    }
}
