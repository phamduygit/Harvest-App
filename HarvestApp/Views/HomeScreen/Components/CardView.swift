//
//  CardView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 12/06/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    var item : Item
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            ZStack (alignment: .top){
                AnimatedImage(url: URL(string: item.image))
                    .resizable()
                    .frame(width: 180, height: 180, alignment: .center)
                    .cornerRadius(20)
                HStack {
                    Text(item.category)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.white.opacity(0.4))
                        .cornerRadius(20)
                    Spacer()
//                    Button(action: {
//
//                    }, label: {
//                        if isLike {
//                            Image(systemName: "heart.fill")
//                                .resizable()
//                                .frame(width: 18, height: 18, alignment: .center)
//                                .foregroundColor(Color.white)
//                        }
//                        else {
//                            Image(systemName: "heart")
//                                .resizable()
//                                .frame(width: 18, height: 18, alignment: .center)
//                                .foregroundColor(Color.white)
//                        }
//                    })
                }
                .padding()
            }
            .frame(width: 180, height: 180, alignment: .center)
            Text(item.name)
                .font(.system(size: 18))
                .foregroundColor(Color.black)
                .fontWeight(.bold)
            HStack {
                Text("\(item.price, specifier: "%.0f")")
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
                Text("đ/kg")
                    .foregroundColor(Color.black.opacity(0.5))
            }
            .font(.system(size: 18))
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(item: Item())
    }
}
