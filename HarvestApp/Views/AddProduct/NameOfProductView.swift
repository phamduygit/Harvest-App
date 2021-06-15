//
//  NameOfProductView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 16/06/2021.
//

import SwiftUI

struct NameOfProductView: View {
    @Binding var show : Bool
    @Binding var selected : Int
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
                Text("Tên nông sản")
                    .font(.title2)
                    .fontWeight(.medium)
            }
            ForEach(rices.indices) {index in
                Button(action: {
                    self.selected = index
                    self.show.toggle()
                }, label: {
                    HStack {
                        Text(rices[index])
                            .font(.headline)
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                })
                
                    
            }
            Spacer()
        }
        .background(Color("Color4").ignoresSafeArea())
    }
}

struct NameOfProductView_Previews: PreviewProvider {
    static var previews: some View {
        NameOfProductView(show: Binding.constant(false), selected: Binding.constant(0))
    }
}
