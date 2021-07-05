//
//  UpdateListWeightView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 04/07/2021.
//

import SwiftUI

struct UpdateListWeightView: View {
    @Binding var show : Bool
    @Binding var product : Product
    @State private var indexUpdate: Int = -1
    @State private var showUpdateWeight : Bool = false
    @State private var showAddWeight : Bool = false
    @EnvironmentObject var categoryViewModel : CategoryViewModel
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
                        Button(action: {
                            self.showAddWeight.toggle()
                            self.indexUpdate = product.weight.count
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
                    Text("Danh sách \(categoryViewModel.getOneCategory(categoryName: product.category).type) \(product.category.lowercased())")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Divider()
                        ForEach(self.product.weight.indices ,id: \.self) {index in
                            Button(action: {
                                self.indexUpdate = index
                                self.showUpdateWeight.toggle()
                            }, label: {
                                HStack {
                                    Text("Bao thứ \(index + 1)")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                    Spacer()
                                    Text("\(self.product.weight[index], specifier: "%.2f") kg")
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
            if showUpdateWeight {
                UpdateWeightView(show: $showUpdateWeight, product: $product, indexUpdate: $indexUpdate, type: categoryViewModel.getOneCategory(categoryName: product.category).type, number: "\(self.product.weight[indexUpdate])")
            }
            if showAddWeight {
                AddWeightView(show: $showAddWeight, product: $product, indexOfSack: $indexUpdate, type: categoryViewModel.getOneCategory(categoryName: product.category).type)
            }
        }
    }
}

struct UpdateListWeightView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateListWeightView(show: Binding.constant(false), product: Binding.constant(Product()))
    }
}
