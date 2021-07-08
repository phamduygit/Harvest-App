//
//  DetailPostInStockView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 08/07/2021.
//

import SwiftUI

struct DetailPostInStockView: View {
    @Binding var show: Bool
    @Binding var product: Product
    @Binding var post: Post
    @State private var showEdit: Bool = false
    @EnvironmentObject var postViewModel : PostViewModel
    @EnvironmentObject var stockViewModel: StockViewModel
    @State private var showSellingView: Bool = false
    @State private var price: String = ""
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
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
                            self.showEdit.toggle()
                        }, label: {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(Color.black)
                        })
                    }
                    .padding(.horizontal)
                    Text("Kho")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        CardInStock(product: product)
                            .frame(height: 100)
                            .cornerRadius(10)
                            .padding()
                        Text("Đăng bán")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        VStack(spacing: 10) {
                            HStack {
                                Text("Tên nông sản")
                                    .font(.headline)
                                Spacer()
                                Text(post.productName)
                                    .font(.headline)
                                    .foregroundColor(Color.black.opacity(0.4))
                            }
                            .padding(.vertical)
                            VStack (alignment: .leading, spacing: 10 ) {
                                Text("Sản lượng")
                                    .font(.headline)
                                HStack {
                                    Text("\(post.weight, specifier: "%.2f")")
                                    Spacer()
                                    Text("kg")
                                }
                                Divider()
                            }
                            VStack (alignment: .leading, spacing: 10 ) {
                                Text("Giá")
                                    .font(.headline)
                                HStack {
                                    Text("\(post.price, specifier: "%.0f")")
                                    Spacer()
                                    Text("đ/kg")
                                }
                                Divider()
                            }
                            VStack (alignment: .leading, spacing: 10 ) {
                                Text("Mô tả")
                                    .font(.headline)
                                HStack {
                                    Text(post.description)
                                }
                                Divider()
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                }
                .padding(.bottom, 80)
            }
            .overlay(
                HStack(spacing: 30) {
                    Button(action: {
                        product.status = 1
                        stockViewModel.saveProduct(product: product)
                        postViewModel.deletePost(post: post)
                        show.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Huỷ đăng")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.red)
                        .clipShape(Capsule())
                        
                    })
                    Button(action: {
                        product.price = post.price
                        showSellingView.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Đã bán")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.yellow)
                        .clipShape(Capsule())
                        
                    })
                }
                .padding(.horizontal)
                .padding(.bottom)
                , alignment: .bottom
            )
            .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
            .sheet(isPresented: $showSellingView) {
                SellingView(show: $showSellingView, showStock: $show, product: $product, post: $post)
            }
            if showEdit {
                EditPostView(show: $showEdit, product: $product, post: $post)
            }
            
        }
        
    }
}

struct DetailPostInStockView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPostInStockView(show: Binding.constant(false), product: Binding.constant(Product()), post: Binding.constant(Post()))
    }
}
