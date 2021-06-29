//
//  DetailNotificationView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI

struct DetailNotificationView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Đặt cọc")
                    .font(.title)
                    .fontWeight(.bold)
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
                Divider()
                VStack(alignment: .leading, spacing: 5) {
                    Text("Thông tin đặt cọc")
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    HStack {
                        Text("Giá")
                        Spacer()
                        Text("5800 đ/kg")
                    }
                    HStack {
                        Text("Sản lượng")
                        Spacer()
                        Text("5000 kg")
                    }
                    HStack {
                        Text("Giá đặt cọc")
                        Spacer()
                        Text("\(5000000) đ")
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                Spacer()
                Divider()
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Trần Long")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            Text("Bán lúa")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.5))
                        }
                        Spacer()
                        HStack(spacing: 15) {
                            Image(systemName: "envelope.fill")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: .center)
                                .foregroundColor(Color.white)
                                .padding(10)
                                .background(Color.yellow)
                                .cornerRadius(10)
                            Image(systemName: "phone.fill")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: .center)
                                .foregroundColor(Color.white)
                                .padding(10)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
    }
}

struct DetailNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNotificationView()
    }
}
