//
//  ListWeightView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 16/06/2021.
//

import SwiftUI

struct ListWeightView: View {
    @Binding var category: String
    @Binding var show : Bool
    @State private var listWeightOfSack = [49.6, 49.6, 49.6, 49.6, 49.6]
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                HStack {
                    Button(action: {
//                        self.show.toggle()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.black)
                    })
                    Spacer()
                    Button(action: {
//                        self.show.toggle()
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
                    ForEach(listWeightOfSack.indices) {index in
                        
                        HStack {
                            Text("Bao thứ \(index + 1)")
                                .fontWeight(.bold)
                            Spacer()
                            Text("\(listWeightOfSack[index], specifier: "%.2f") kg")
                                .foregroundColor(Color.black.opacity(0.5))
                            Image(systemName: "chevron.right")
                        }
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
    }
}

struct ListWeightView_Previews: PreviewProvider {
    static var previews: some View {
        ListWeightView(category: Binding.constant("lúa"), show: Binding.constant(false))
    }
}
