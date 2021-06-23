//
//  CustomTabBarView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 11/06/2021.
//

import SwiftUI

struct CustomTabBarView: View {
    var tabs = ["house", "newspaper", "plus.circle.fill", "arrow.left.arrow.right", "person"]
    @State private var isClickedPlus : Bool = false
    @State private var showStock: Bool = false
    @Binding var selection : Int
    @State private var showAddProdct : Bool = false
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    ForEach(tabs.indices) {index in
                        GeometryReader { geometry in
                            Button(action: {
                                withAnimation {
                                    if index != 2 {
                                        if !isClickedPlus {
                                            selection = index
                                        }
                                    } else {
                                        self.isClickedPlus.toggle()
                                    }
                                }
                            }, label: {
                                VStack {
                                    HStack {
                                        Spacer()
                                        if index == 2 {
                                            Image(systemName: tabs[index])
                                                .resizable()
                                                .frame(width: index == 2 ? 36 : 24, height: index == 2 ? 36 : 24, alignment: .center)
                                                .foregroundColor(Color.green)
                                                .rotationEffect(isClickedPlus ? .degrees(45) : .degrees(0))
                                        }
                                        else {
                                            if !isClickedPlus {
                                                Image(systemName: tabs[index])
                                                    .resizable()
                                                    .frame(width: index == 2 ? 36 : 24, height: index == 2 ? 36 : 24, alignment: .center)
                                                    .foregroundColor(selection == index ? Color.black : Color.black.opacity(0.5))
                                            }
                                            
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                .frame(width: geometry.size.width, height: 60, alignment: .center)
                            })
                        }
                        .frame(height: isClickedPlus ? 60 : 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
                .background(Color.white)
                if isClickedPlus {
                    VStack {
                        
                        Button(action: {
                            self.showAddProdct.toggle()
                            self.isClickedPlus.toggle()
                        }, label: {
                            HStack(spacing: 20) {
                                Image(systemName: "tray.and.arrow.down")
                                    .resizable()
                                    .frame(width: 24, height: 24, alignment: .center)
                                Text("Thu hoạch")
                                    .font(.title2)
                                Spacer()
                            }
                            .foregroundColor(Color.black)
                        })
                        Button(action: {
                            self.showStock.toggle()
                            self.isClickedPlus.toggle()
                        }, label: {
                            HStack(spacing: 20) {
                                Image(systemName: "tray.full")
                                    .resizable()
                                    .frame(width: 24, height: 24, alignment: .center)
                                Text("Xem kho")
                                    .font(.title2)
                                Spacer()
                            }
                            .foregroundColor(Color.black)
                        })
                    }
                    .padding()
                    .padding(.bottom)
                    .background(Color.white)
                }
            }
            if showAddProdct {
                ChoseProductView(show: $showAddProdct)
            }
            if showStock {
                StockView(show: $showStock)
            }
        }
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView(selection: Binding.constant(0))
    }
}
