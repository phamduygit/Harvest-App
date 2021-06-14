//
//  HomeView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 09/06/2021.
//

import SwiftUI

struct HomeView: View {
    @State private var key : String = ""
    @State private var isLike : Bool = true
    var body: some View {
        ZStack {
            VStack (alignment: .leading){
                ZStack {
                    HStack {
                        Image("avatar")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipShape(Circle())
                        Spacer()
                        Button(action: {}, label: {
                            Image(systemName: "bell")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: .center)
                                .foregroundColor(Color.black)
                        })
                        
                    }
                    .padding()
                    VStack {
                        Text("Chào buổi sáng")
                        Text("Phạm Duy")
                            .fontWeight(.bold)
                    }
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        TextField("Tìm kiếm nông sản", text: $key)
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                            
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding()
                    HStack {
                        Text("Nông sản yêu thích")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (spacing: 10) {
                            CardView(isLike: $isLike)
                                .padding(.leading)
                            CardView(isLike: $isLike)
                            CardView(isLike: $isLike)
                        }
                    }
                }
            }
            .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
