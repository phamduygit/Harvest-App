//
//  CardInStock.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 23/06/2021.
//

import SwiftUI

struct CardInStock: View {
    @Binding var item : ItemInStock
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("lightblue"), Color.blue]), startPoint: .leading, endPoint: .trailing)
            HStack {
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "trash")
                        .foregroundColor(Color.white)
                        .font(.title)
                })
                .padding()
            }
            HStack {
                Image(item.image)
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(10)
                VStack(alignment: .leading, spacing: 15) {
                    Text(item.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    HStack {
                        Text("Sản lượng")
                            .fontWeight(.bold)
                            .foregroundColor(Color.black.opacity(0.5))
                        Spacer()
                        Text("\(item.totalWeight, specifier: "%.2f") kg")
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
    }
}

struct ItemInStock: Identifiable {
    var id : Int
    var name : String
    var image : String
    var totalWeight: Float
    var offset: CGFloat
    var isSwiped: Bool
}
struct CardInStock_Previews: PreviewProvider {
    static var previews: some View {
        CardInStock(item: Binding.constant(ItemInStock(id: 1, name: "Lúa Jasmine", image: "rice", totalWeight: 5000, offset: 0, isSwiped: false)))
    }
}
