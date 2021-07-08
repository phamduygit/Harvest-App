//
//  DetailSoldView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 08/07/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailSoldView: View {
    @Binding var product : Product
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
                            HStack {
                                Text("Giá")
                                Spacer()
                                Text("\(product.price, specifier: "%.0f") đ/kg")
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            HStack {
                                Text("Doanh thu")
                                Spacer()
                                Text("\(product.price * product.weight.reduce(0, +), specifier: "%.0f") đồng")
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
        }
    }
}

struct DetailSoldView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSoldView(product: Binding.constant(Product()), show: Binding.constant(false))
    }
}
