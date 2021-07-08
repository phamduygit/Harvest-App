//
//  EditPostView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 08/07/2021.
//

import SwiftUI

struct EditPostView: View {
    @Binding var show : Bool
//    @ObservedObject var weigth = NumbersOnly()
    @ObservedObject var price = NumbersOnly()
    @State private var description : String = ""
    @Binding var product : Product
    @Binding var post: Post
    @EnvironmentObject var postViewModel: PostViewModel
//    @State private var showAlert: Bool = false
    var body: some View {
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
                                TextField("Nhập giá", text: $price.value)
                                    .keyboardType(.decimalPad)
                                    .onAppear() {
                                        price.value = String(format: "%.2f", (post.price))
                                    }
                                Spacer()
                                Text("đ/kg")
                            }
                            Divider()
                        }
                        VStack (alignment: .leading, spacing: 10 ) {
                            Text("Mô tả")
                                .font(.headline)
                            HStack {
                                TextField("Nhập mô tả", text: $description)
                                    .onAppear() {
                                        description = post.description
                                    }
                            }
                            Divider()
                        }
                    }
                    .padding(.horizontal)
                }
                
            }
        }
        .padding(.bottom, 60)
//        .alert(isPresented: $showAlert, content: {
//            Alert(title: Text("Sản lượng không đủ"), message: Text("Vui lòng nhập lại sản lượng muốn bán"), dismissButton: .default(Text("OK")))
//        })
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
                    post.price = (price.value as NSString).floatValue
                    post.description = description
                    postViewModel.updatePost(post: post)
                    show.toggle()
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
        .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
    }
}

struct EditPostView_Previews: PreviewProvider {
    static var previews: some View {
        EditPostView(show: Binding.constant(false), product: Binding.constant(Product()), post: Binding.constant(Post()))
    }
}
