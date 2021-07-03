//
//  DetailInStockView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 20/06/2021.
//

import SwiftUI

struct DetailInStockView: View {
    @State private var indexFilter : Int = 0
    @State private var showNames : Bool = false
    @State private var showInputWeight : Bool = false
    @State private var ricesCategory = ["Lúa Jasmine", "Lúa IR 50404", "Lúa OM 9577", "Lúa OM 9582"]
    @State private var selected : String = "Lúa Jasmine"
    @Binding var listWeightOfSack : [Sack]
    @Binding var show : Bool
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
                    .padding()
                    Text("Kho")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Chọn nông sản")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.horizontal)
                        ZStack {
                            Image("cate_rice")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(height: UIScreen.main.bounds.height / 2)
                        Button(action: {
                            showNames.toggle()
                        }, label: {
                            HStack {
                                Text("Tên nông sản")
                                Spacer()
                                Text(rices[indexFilter])
                                Image(systemName: "chevron.right")
                                
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                        })
                        .padding(.horizontal)
                        .padding(.bottom)
                        Button(action: {
                            showInputWeight.toggle()
                        }, label: {
                            HStack {
                                Text("Tổng sản lượng")
                                Spacer()
                                Text("\(listWeightOfSack.map({$0.weight}).reduce(0, +), specifier: "%.2f") kg")
                                Image(systemName: "chevron.right")
                                
                            }
                            .foregroundColor(Color.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                        })
                        .padding(.horizontal)
                        .padding(.bottom)
                        HStack {
                            Button(action: {
    //                            self.showInputWeight.toggle()
                            }, label: {
                                HStack {
                                    Spacer()
                                    Text("Đã bán")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                    Spacer()
                                }
                                .padding()
                                .background(Color.yellow)
                                .clipShape(Capsule())
                                .padding()
                                .padding(.bottom)
                                
                            })
                            Button(action: {
    //                            self.showInputWeight.toggle()
                            }, label: {
                                HStack {
                                    Spacer()
                                    Text("Đăng bán")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                    Spacer()
                                }
                                .padding()
                                .background(Color("Color5"))
                                .clipShape(Capsule())
                                .padding()
                                .padding(.bottom)
                                
                            })
                        }
                    }
                }
                
            }
            .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
            if showNames {
                NameOfProductView(show: $showNames, selected: $selected, ricesCategory: $ricesCategory)
            }
            if showInputWeight {
                ListWeightView(category: "lúa", show: $showInputWeight, listWeightOfSack: $listWeightOfSack)
            }
        }
    }
}

struct DetailInStockView_Previews: PreviewProvider {
    static var previews: some View {
        DetailInStockView(listWeightOfSack: Binding.constant([Sack(id: 0, weight: 49.6), Sack(id: 1, weight: 49.6), Sack(id: 2, weight: 49.6), Sack(id: 3, weight: 49.6), Sack(id: 4, weight: 49.6)]), show: Binding.constant(false))
    }
}
