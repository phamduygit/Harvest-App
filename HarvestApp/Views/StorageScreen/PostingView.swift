//
//  PostingView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 23/06/2021.
//

import SwiftUI

struct PostingView: View {
    @Binding var show : Bool
    @Binding var showDetail : Bool
    @ObservedObject var weigth = NumbersOnly()
    @ObservedObject var price = NumbersOnly()
    @State private var description : String = ""
    @Binding var product : Product
    @StateObject var postViewModel = PostViewModel()
    @StateObject var userViweModel = UserViewModel()
    @EnvironmentObject var stockViewModel : StockViewModel
    @State private var showAlert: Bool = false
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
                                TextField("Nhập sản lượng", text: $weigth.value)
                                    .keyboardType(.decimalPad)
                                    .onAppear() {
                                        weigth.value = String(format: "%.2f", (product.weight.reduce(0, +)))
                                    }
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
                    .padding(.horizontal)
                }
                
            }
        }
        .padding(.bottom, 60)
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Sản lượng không hợp lệ"), message: Text("Vui lòng nhập lại sản lượng muốn bán"), dismissButton: .default(Text("OK")))
        })
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
                    posting()
                    
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
            , alignment: .bottom
        )
        .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
    }
    func posting() {
        if (weigth.value as NSString).floatValue > 0 {
            if product.weight.reduce(0, +) - (weigth.value as NSString).floatValue == 0 {
                postViewModel.addPost(product: product, userInfo: userViweModel.user, price: (price.value as NSString).floatValue, totalWeight: (weigth.value as NSString).floatValue, description: description)
                product.status = 2
                stockViewModel.saveProduct(product: product)
                showDetail.toggle()
            } else if product.weight.reduce(0, +) - (weigth.value as NSString).floatValue > 0 {
                let newProduct = stockViewModel.postProdct(product: product, totalWeight: (weigth.value as NSString).floatValue)
                postViewModel.addPost(product: newProduct, userInfo: userViweModel.user, price: (price.value as NSString).floatValue, totalWeight: (weigth.value as NSString).floatValue, description: description)
                showDetail.toggle()
            } else {
                self.showAlert.toggle()
            }
        } else {
            self.showAlert.toggle()
        }
        
    }
}

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber || $0 == "."}
            if value != filtered {
                value = filtered
            }
        }
    }
}

struct PostingView_Previews: PreviewProvider {
    static var previews: some View {
        PostingView(show: Binding.constant(false), showDetail: Binding.constant(false), product: Binding.constant(Product()))
    }
}
