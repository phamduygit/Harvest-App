//
//  NumPad.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 11/07/2021.
//

import SwiftUI

struct NumPad: View {
    @State private var numPad = [
        ColumnNum(id: 0, value: ["1", "4", "7", "."]),
        ColumnNum(id: 1, value: ["2", "5", "8", "0"]),
        ColumnNum(id: 2, value: ["3", "6", "9", "delete.left"])
    ]
    @Binding var number : String
    @Binding var product: Product
    @Binding var indexOfSack: Int
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top) {
                ForEach(numPad) {column in
                    GeometryReader {geometry in
                        VStack (spacing: 10){
                            ForEach(column.value.indices) {index in
                                Button (action: {
                                    if (column.value[index] == "delete.left") {
                                        if number.count == 1 {
                                            number = "0.0"
                                        } else {
                                            if number != "0.0" {
                                                number.removeLast()
                                            }
                                        }
                                    }
                                    else {
                                        if number == "0.0" {
                                            number = column.value[index]
                                        }
                                        else {
                                            number += column.value[index]
                                        }
                                        
                                    }
                                }, label: {
                                    HStack {
                                        if (column.value[index] == "delete.left") {
                                            Image(systemName: "delete.left")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                        }
                                        else {
                                            Text(column.value[index])
                                                .fontWeight(.bold)
                                                .font(.title)
                                        }
                                    }
                                    .foregroundColor(Color.black)
                                    .frame(width: geometry.size.width, height: 50, alignment: .center)
                                    .background(Color("Color5").opacity(0.5))
                                    .cornerRadius(15)
                                })
                                
                            }
                        }
                        .frame(height: UIScreen.main.bounds.width, alignment: .top)
                    }
                }
                
            }
            .frame(height: 230)
            Button(action:{
//                    print("\(Double(number) ?? 0.0)")
                self.product.weight.append(Float(number) ?? 0.0)
                self.indexOfSack += 1
                number = "0.0"
            }) {
                HStack {
                    Spacer()
                    Image(systemName: "arrow.right")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.black)
                    Spacer()
                }
                .frame(height: 50)
                .background(Color("Color5"))
                .cornerRadius(15)
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct NumPad_Previews: PreviewProvider {
    static var previews: some View {
        NumPad(number: Binding.constant("0.0"), product: Binding.constant(Product()), indexOfSack: Binding.constant(-1))
    }
}
