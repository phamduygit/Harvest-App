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
            if currentTab == "Nhập" {
                Spacer()
                NumPad(number: $number, product: $product, indexOfSack: $indexOfSack)
            } else {
                Spacer()
                ScanView()
                Spacer()
            }
        }
        .background(Color("Color4").ignoresSafeArea())
        
    }
}

struct AddWeightView_Previews: PreviewProvider {
    static var previews: some View {
        AddWeightView(show: Binding.constant(false), product: Binding.constant(Product()), indexOfSack: Binding.constant(0), number: "0.0", type: "bao")
    }
}
