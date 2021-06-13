//
//  ItemCardView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 13/06/2021.
//

import SwiftUI

struct ItemCardView: View {
    var body: some View {
        HStack {
            Image("rice")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(10)
            VStack(spacing: 8) {
                HStack {
                    Text("Lúa jasmine")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "heart")
                            .foregroundColor(Color.red)
                    })
                }
                HStack {
                    Text("Lúa")
                        .font(.headline)
                        .foregroundColor(Color.black.opacity(0.6))
                    Spacer()
                }
                HStack {
                    Text("\(5900) đ")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    HStack {
                        Image(systemName: "arrow.up")
                            .foregroundColor(Color.green)
                        Text("\(100)đ")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct ItemCardView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCardView()
    }
}
