//
//  DetailPostVIew.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI

struct DetailPostVIew: View {
    @Binding var show: Bool
    @Binding var showTabBar : Bool
    var body: some View {
        VStack {
            Image("rice")
                .resizable()
                .frame(height: 300)
                .aspectRatio(contentMode: .fit)
            VStack {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Trần Văn Lâm")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            Text("Bán lúa")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.5))
                        }
                        Spacer()
                        HStack(spacing: 15) {
                            Image(systemName: "envelope.fill")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(Color.white)
                                .padding(10)
                                .background(Color.yellow)
                                .cornerRadius(10)
                            Image(systemName: "phone.fill")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(Color.white)
                                .padding(10)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom, 10)
                    Divider()
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Lúa jasmine")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                        HStack {
                            Text("Giá")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.5))
                            Spacer()
                            Text("5900 đ/kg")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.5))
                        }
                        HStack {
                            Text("Sản lượng")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.5))
                            Spacer()
                            Text("5000 kg")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.5))
                        }
                        HStack {
                            Text("Tổng")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.5))
                            Spacer()
                            Text("\(5900 * 5000) đ")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.5))
                        }
                    }
                    Spacer()
                    
                }
                .padding(.top, 10)
                .padding()
                .background(Color.white)
                .clipShape(RoundedTop())
                .offset(y: -50)
                Spacer()
                Button(action: {}, label: {
                    HStack {
                        Spacer()
                        Text("Đặt cọc")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding()
                    .background(Color("Color5"))
                    .cornerRadius(40)
                })
                .padding()
                .padding(.bottom)
            }
            .background(Color.white)
            

        }
        .ignoresSafeArea(.all, edges: .all)
        .overlay(
            Button(action: {
                self.show.toggle()
                self.showTabBar.toggle()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.4))
                    .clipShape(Circle())
            })
            .padding(.leading),
            alignment: .topLeading
        )
    }
}

struct DetailPostVIew_Previews: PreviewProvider {
    static var previews: some View {
        DetailPostVIew(show: Binding.constant(false), showTabBar: Binding.constant(false))
    }
}
