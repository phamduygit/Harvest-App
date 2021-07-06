//
//  PostView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI

struct PostView: View {
    @Binding var show : Bool
    @State private var weight : String = ""
    @State private var price : String = ""
    @State private var description : String = ""
    @Binding var product : Product
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
                            Text("Lúa jasmine")
                                .font(.headline)
                                .foregroundColor(Color.black.opacity(0.4))
                        }
                        .padding(.vertical)
                        VStack (alignment: .leading, spacing: 10 ) {
                            Text("Sản lượng")
                                .font(.headline)
                            HStack {
                                TextField("Nhập sản lượng", text: $weight)
                                Spacer()
                                Text("kg")
                            }
                            Divider()
                        }
                        VStack (alignment: .leading, spacing: 10 ) {
                            Text("Giá")
                                .font(.headline)
                            HStack {
                                TextField("Nhập giá", text: $price)
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
                            }
                            Divider()
                        }
                    }
//                    .padding()
                    .padding(.horizontal)
                }
                HStack(spacing: 30) {
                    Button(action: {
    //                            self.showInputWeight.toggle()
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
    //                            self.showInputWeight.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Đăng")
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
            }
            
            
        }
        .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView(show: Binding.constant(false), product: <#Binding<Product>#>)
//    }
//}
