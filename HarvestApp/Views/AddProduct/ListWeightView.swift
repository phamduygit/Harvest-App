//
//  ListWeightView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 16/06/2021.
//

import SwiftUI

struct ListWeightView: View {
    var category: String
    @Binding var show : Bool
    @State var listWeightOfSack = [
        Sack(id: 0, weight: 49.6),
        Sack(id: 1, weight: 49.6),
        Sack(id: 2, weight: 49.6),
        Sack(id: 3, weight: 49.6),
        Sack(id: 4, weight: 49.6)
    ]
    @State private var indexUpdate = 0
    @State private var showUpdateWeight : Bool = false
    @State private var showAddWeight : Bool = false
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
                            self.showAddWeight.toggle()
                            self.indexUpdate = listWeightOfSack.count
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(Color.black)
                        })
                    }
                    .padding()
                    Text("Thu hoạch")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                HStack {
                    Text("Danh sách bao \(category)")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Divider()
                        ForEach(listWeightOfSack, id: \.id) {item in
                            
                            Button(action: {
                                self.indexUpdate = item.id
                                self.showUpdateWeight.toggle()
                            }, label: {
                                HStack {
                                    Text("Bao thứ \(item.id + 1)")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                    Spacer()
                                    Text("\(item.weight, specifier: "%.2f") kg")
                                        .foregroundColor(Color.black.opacity(0.5))
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.black)
                                }
                            })
                            
                            Divider()
                        }
                    }
                }
                .padding()
                Spacer()
            }
            .background(Color("Color4").ignoresSafeArea())
            .overlay(
                Button(action: {}, label: {
                    HStack {
                        Spacer()
                        Text("Lưu")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding()
                    .background(Color("Color5"))
                    .clipShape(Capsule())
                })
                .padding()
                .padding(.bottom)
                , alignment: .bottom
            )
            if showUpdateWeight {
                UpdateWeightView(show: $showUpdateWeight, listWeightOfSack: $listWeightOfSack, indexOfSack: $indexUpdate, number: "\(listWeightOfSack[indexUpdate].weight)")
            }
            if showAddWeight {
                AddWeightView(show: $showAddWeight, listWeightOfSack: $listWeightOfSack, indexOfSack: $indexUpdate, number: "0.0")
            }
        }
    }
}
struct Sack : Identifiable{
    var id : Int
    var weight : Double
}
struct ListWeightView_Previews: PreviewProvider {
    static var previews: some View {
        ListWeightView(category: "lúa", show: Binding.constant(false))
    }
}
