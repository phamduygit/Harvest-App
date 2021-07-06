//
//  DetailInStockView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 20/06/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailInStockView: View {
    @State private var showNames : Bool = false
    @State private var showInputWeight : Bool = false
    @State private var ricesCategory = ["Lúa Jasmine", "Lúa IR 50404", "Lúa OM 9577", "Lúa OM 9582"]
    @State private var selected : String = "Lúa Jasmine"
    @Binding var product : Product
    @Binding var show : Bool
    @EnvironmentObject var stockViewModel : StockViewModel
    @State private var showEdit : Bool = false
    @State private var showPosting : Bool = false
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
                    VStack {
                        HStack {
                            Text("Chi tiết nông sản")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.horizontal)
                        ZStack {
                            AnimatedImage(url: URL(string: product.image))
                                .resizable()
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fit)
                        }
                        .padding()
                        .frame(height: UIScreen.main.bounds.height / 3)
                        VStack {
                            HStack {
                                Text("Tên nông sản")
                                Spacer()
                                Text(product.name)
                                
                            }
                            .onAppear {
                                self.selected = product.name
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            HStack {
                                Text("Tổng sản lượng")
                                Spacer()
                                Text("\(product.weight.reduce(0, +), specifier: "%.2f") kg")
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                    }
                }
                
            }
            .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
            .overlay(
                HStack(spacing: 20) {
                    Button(action: {
                        product.status = 3
                        stockViewModel.saveProduct(product: product)
                        show.toggle()
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
                    Button(action: {
                        self.showPosting.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Đăng bán")
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
            if showEdit {
                UpdateProductView(product: $product, show: $showEdit)
            }
            if showPosting {
                PostView(show: $showPosting, product: $product)
            }
        }
    }
}

//struct DetailInStockView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailInStockView(indexDetail: Binding.constant(-1), show: Binding.constant(false))
//    }
//}
