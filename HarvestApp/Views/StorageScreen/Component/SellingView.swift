//
//  SellingView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 08/07/2021.
//

import SwiftUI

struct SellingView: View {
    @Binding var show: Bool
    @Binding var showStock: Bool
    @Binding var product: Product
    @Binding var post: Post
    @ObservedObject var price = NumbersOnly()
    @EnvironmentObject var stockViewModel: StockViewModel
    @EnvironmentObject var postViewModel : PostViewModel
    var body: some View {
        NavigationView {
            VStack {
                VStack (spacing: 10) {
                    HStack {
                        Text("Tên nông sản")
                            .font(.headline)
                        Spacer()
                        Text(product.name)
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.4))
                    }
                    .padding(.vertical)
                    VStack (alignment: .leading, spacing: 10 ) {
                        Text("Sản lượng")
                            .font(.headline)
                        HStack {
                            Text("\(product.weight.reduce(0, +), specifier: "%.2f")")
                            Spacer()
                            Text("kg")
                        }
                        Divider()
                    }
                    VStack (alignment: .leading, spacing: 10 ) {
                        Text("Giá")
                            .font(.headline)
                        HStack {
                            TextField("Nhập giá", text: $price.value)
                                .keyboardType(.decimalPad)
                                .onAppear() {
                                    price.value = String(format: "%.2f", (product.price))
                                }
                            Spacer()
                            Text("đ/kg")
                        }
                        Divider()
                    }
                }
                .padding()
                Spacer()
            }
            .overlay(
                HStack(spacing: 30) {
                    Button(action: {
                        show.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Huỷ")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.gray)
                        .clipShape(Capsule())
                        
                    })
                    Button(action: {
                        product.status = 3
                        product.price = (price.value as NSString).floatValue
                        stockViewModel.saveProduct(product: product)
                        if post.id != nil {
                            postViewModel.deletePost(post: post)
                        }
                        show.toggle()
                        showStock.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Lưu")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color("Color5"))
                        .clipShape(Capsule())
                        
                    })
                }
                .padding(.horizontal)
                .padding(.bottom)
                , alignment: .bottom
            )
            .navigationBarTitle("Xác nhận đã bán")
        }
    }
}

struct SellingView_Previews: PreviewProvider {
    static var previews: some View {
        SellingView(show: Binding.constant(false), showStock: Binding.constant(false), product: Binding.constant(Product()), post: Binding.constant(Post()))
    }
}
