//
//  ListWeightView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 16/06/2021.
//

import SwiftUI

struct ListWeightView: View {
    @Binding var showInputWeigth: Bool
    @Binding var showAddProdct: Bool
    @EnvironmentObject var productViewModel : ProductViewModel
    @EnvironmentObject var categoryViewModel : CategoryViewModel
    @State private var indexUpdate: Int = -1
    @State private var showUpdateWeight : Bool = false
    @State private var showAddWeight : Bool = false
    @State private var showAddToStorage : Bool = false
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    HStack {
                        Button(action: {
                            self.showInputWeigth.toggle()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.black)
                        })
                        Spacer()
                        Button(action: {
                            self.showAddWeight.toggle()
                            self.indexUpdate = productViewModel.product.weight.count
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(Color.black)
                        })
                    }
                    .padding()
                    Text("Thu hoạch")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                HStack {
                    Text("Danh sách \(categoryViewModel.getOneCategory(categoryName: productViewModel.product.category).type) \(productViewModel.product.category.lowercased())")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Divider()
                        ForEach(productViewModel.product.weight.indices ,id: \.self) {index in
                            Button(action: {
                                self.indexUpdate = index
                                self.showUpdateWeight.toggle()
                            }, label: {
                                HStack {
                                    Text("Bao thứ \(index + 1)")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                    Spacer()
                                    Text("\(productViewModel.product.weight[index], specifier: "%.2f") kg")
                                        .foregroundColor(Color.black.opacity(0.5))
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.black)
                                }
                            })
                            
                            Divider()
                        }
                    }
                }
                .padding()
                Spacer()
            }
            .background(Color("Color4").ignoresSafeArea())
            .overlay(
                Button(action: {
                    self.showAddToStorage.toggle();
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
                    .background(Color("Color5"))
                    .clipShape(Capsule())
                })
                .padding()
                .padding(.bottom)
                , alignment: .bottom
            )
            if showUpdateWeight {
                UpdateWeightView(show: $showUpdateWeight, product: $productViewModel.product, indexUpdate: $indexUpdate, type: categoryViewModel.getOneCategory(categoryName: productViewModel.product.category).type, number: "\(productViewModel.product.weight[indexUpdate])")
            }
            if showAddWeight {
                AddWeightView(show: $showAddWeight, product: $productViewModel.product, indexOfSack: $indexUpdate, type: categoryViewModel.getOneCategory(categoryName: productViewModel.product.category).type)
            }
            if showAddToStorage {
                AddToStorageView(showAddToStorage: $showAddToStorage, showAddProdct: $showAddProdct)
            }
        }
    }
}

struct ListWeightView_Previews: PreviewProvider {
    static var previews: some View {
        ListWeightView(showInputWeigth: Binding.constant(false), showAddProdct: Binding.constant(false))
    }
}
