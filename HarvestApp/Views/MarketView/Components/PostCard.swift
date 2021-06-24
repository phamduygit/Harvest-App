//
//  PostCard.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI

struct PostCard: View {
    @Binding var isTapDetail : Bool
    @Binding var showTabBar : Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 15) {
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60, alignment: .center)
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Trần Lâm")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                        Text("08/08/2021")
                            .font(.subheadline)
                            .foregroundColor(Color.black.opacity(0.5))
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "bookmark")
                            .font(.title)
                            .foregroundColor(Color.black)
                    })
                    
                }
            }
            Text("Tôi cần bán lúa jasmine")
                .foregroundColor(Color.black)
            HStack(spacing: 10) {
                Image("rice")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(10)
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Lúa jasmine")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                        Text("Sản lượng: \(5000) kg")
                            .fontWeight(.medium)
                            .foregroundColor(Color.black)
                        Text("Giá: \(5900) đ/kg")
                            .fontWeight(.medium)
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                }
            }
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(15)
            .onTapGesture {
                self.isTapDetail.toggle()
                self.showTabBar.toggle()
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct PostCard_Previews: PreviewProvider {
    static var previews: some View {
        PostCard(isTapDetail: Binding.constant(false), showTabBar: Binding.constant(false))
    }
}
