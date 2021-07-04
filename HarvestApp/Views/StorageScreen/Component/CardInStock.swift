//
//  CardInStock.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 23/06/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardInStock: View {
    @Binding var product : Product
    @State var item = ItemInStock()
    @State private var showAlert = false
    @EnvironmentObject var stockViewModel : StockViewModel
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("lightblue"), Color.blue]), startPoint: .leading, endPoint: .trailing)
            HStack {
                Spacer()
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Image(systemName: "trash")
                        .foregroundColor(Color.white)
                        .font(.title)
                })
                .padding()
            }
            HStack {
                AnimatedImage(url: URL(string: product.image))
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(10)
                VStack(alignment: .leading, spacing: 15) {
                    Text(product.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    HStack {
                        Text("Sản lượng")
                            .fontWeight(.bold)
                            .foregroundColor(Color.black.opacity(0.5))
                        Spacer()
                        Text("\(product.weight.reduce(0, +), specifier: "%.2f") kg")
                            .fontWeight(.bold)
                            .foregroundColor(Color.black.opacity(0.5))
                    }
                }
            }
            .padding(10)
            .background(Color.white)
            .contentShape(Rectangle())
            .offset(x: item.offset)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        if value.translation.width < 0 {
                            if item.isSwiped {
                                item.offset = value.translation.width - 90
                            }
                            else {
                                item.offset = value.translation.width
                            }
                        }
                        
                    })
                    .onEnded({ value in
                        if value.translation.width < 0 {
                            if value.translation.width < -80 {
                                item.isSwiped = true
                                item.offset = -60
                            }
                            else {
                                item.isSwiped = false
                                item.offset = 0
                            }
                        } else {
                            item.isSwiped = false
                            item.offset = 0
                        }
                    })
            )
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Bạn thực sự muốn xoá nó"),
                message: Text("Sau khi xoá sẽ không hoàn tác được"),
                primaryButton: .destructive(Text("Xoá")) {
                    self.stockViewModel.removeProduct(product: product)
                },
                secondaryButton: .cancel(Text("Huỷ")) {
                    
                }
            )
        }
    }
}

//struct CardInStock_Previews: PreviewProvider {
//    static var previews: some View {
//        CardInStock(item: Binding.constant(ItemInStock(id: 1, name: "Lúa Jasmine", image: "rice", totalWeight: 5000, offset: 0, isSwiped: false)))
//    }
//}
