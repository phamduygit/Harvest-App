//
//  AddWeightView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 17/06/2021.
//

import SwiftUI

struct AddWeightView: View {
    @Binding var show : Bool
    @Binding var product : Product
    @Binding var indexOfSack : Int
    @State var number : String = "0.0"
    var type : String
    enum MethodInputValue : String, CaseIterable {
        case keyboard = "Nhập"
        case scan = "Quét"
    }
    @State private var numPad = [
        ColumnNum(id: 0, value: ["1", "4", "7", "."]),
        ColumnNum(id: 1, value: ["2", "5", "8", "0"]),
        ColumnNum(id: 2, value: ["3", "6", "9", "delete.left"])
    ]
    @State private var currentTab : String = "Nhập"
    var body: some View {
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
                .padding()
                Text("Thu hoạch")
                    .font(.title2)
                    .fontWeight(.medium)
            }
            HStack {
                Text("Nhập")
                    .fontWeight(.bold)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    .background(
                        ZStack {
                            if currentTab == "Nhập" {
                                Color.white.cornerRadius(10)
                            }
                        }
                    )
                    .foregroundColor(currentTab == "Nhập" ? Color.black : Color.white)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            currentTab = "Nhập"
                        }
                    }
                Text("Quét")
                    .fontWeight(.bold)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(
                        ZStack {
                            if currentTab == "Quét" {
                                Color.white.cornerRadius(10)
                            }
                        }
                    )
                    .foregroundColor(currentTab == "Quét" ? Color.black : Color.white)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                            currentTab = "Quét"
                        }
                    }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 7)
            .background(Color.black.opacity(0.35))
            .cornerRadius(10)
            
            VStack (spacing: 10) {
                Text("Nhập trọng lượng \(type) thứ \(indexOfSack + 1)")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("\(number) kg")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(0.5))
            }
            .padding(.top, 20)
            Spacer()
        }
        .background(Color("Color4").ignoresSafeArea())
        .overlay(
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
            , alignment: .bottom
        )
    }
}

struct AddWeightView_Previews: PreviewProvider {
    static var previews: some View {
        AddWeightView(show: Binding.constant(false), product: Binding.constant(Product()), indexOfSack: Binding.constant(0), number: "0.0", type: "bao")
    }
}
