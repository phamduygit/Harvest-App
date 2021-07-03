//
//  AddToStorageView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 18/06/2021.
//

import SwiftUI

struct AddToStorageView: View {
    @State private var showNames : Bool = false
    @State private var showInputWeight : Bool = false
    @State private var ricesCategory = ["Lúa Jasmine", "Lúa IR 50404", "Lúa OM 9577", "Lúa OM 9582"]
    @State private var selected : String = "Lúa Jasmine"
    @EnvironmentObject var productViewModel : ProductViewModel
    @EnvironmentObject var stockViewModel : StockViewModel
    @Binding var show : Bool
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
                            Image("cate_rice")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(height: UIScreen.main.bounds.height / 2)
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
                        Button(action: {
                            showInputWeight.toggle()
                        }, label: {
                            HStack {
                                Text("Tổng sản lượng")
                                Spacer()
                                Text("\(productViewModel.product.weight.reduce(0, +), specifier: "%.2f") kg")
                                Image(systemName: "chevron.right")
                                
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .padding()
                        })
                        Button(action: {
                            stockViewModel.addNewProduct(product: productViewModel.product)
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Thêm vào kho")
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
            if showNames {
                NameOfProductView(show: $showNames, selected: $productViewModel.product.name, ricesCategory: $ricesCategory)
            }
            if showInputWeight {
                ListWeightView(show: $showInputWeight)
            }
        }
    }
}

struct AddToStorageView_Previews: PreviewProvider {
    static var previews: some View {
        AddToStorageView(show: Binding.constant(false))
    }
}
