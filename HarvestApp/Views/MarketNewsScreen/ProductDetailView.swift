//
//  ProductDetailView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 13/06/2021.
//

import SwiftUI

struct ProductDetailView: View {
    enum chose: String, CaseIterable {
        case week = "Tuần"
        case month = "Tháng"
    }
    @State private var currentIndex = 0
    @State private var selection : chose = .week
    @State private var isLike : Bool = false
    @Binding var show : Bool
    @Binding var showTabBar : Bool
    var body: some View {
        ZStack {
            Color("Color4").ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack(spacing: 10) {
                        Image("rice")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedBotton(cornerRaidus: 40))
                            
                        VStack(spacing: 10) {
                            HStack {
                                Text("Lúa jasmine")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("5.900 đ/kg")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            HStack {
                                HStack(spacing: 5) {
                                    Text("Loại cây trồng:")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black.opacity(0.6))
                                        .font(.title3)
                                    Text("Lúa")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black.opacity(0.6))
                                }
                                Spacer()
                            }
                        }
                        .padding()
                        .padding(.bottom)
                    }
                    .background(Color.white)
                    .clipShape(RoundedBotton(cornerRaidus: 40))
                    VStack(spacing: 10) {
                        HStack {
                            Text("Mô tả")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        Text("Gạo Jasmine là loại lúa thơm dẻo có thời gian sinh trưởng ngắn ( hay còn gọi là lúa ngắn ngày). Gạo Jasmine hiện đang được trồng phổ biến rộng rãi chiếm diện tích lớn nhất trong tổng diện tích trồng lúa. Vì gạo jasmine cho năng suất và giá trị cao. Giống lúa cứng cây ít bị ngã đỗ, trỗ tập trung thích hợp trồng vụ đông xuân")
                        
                    }
                    .padding()
                    VStack {
                        HStack {
                            Text("Giá bán gần đây")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        VStack {
                            Picker("Chọn chế đọ xem", selection: $selection) {
                                ForEach(chose.allCases, id: \.self) {
                                    Text($0.rawValue)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            HStack {
                                ForEach(data.indices) {index in
                                    GeometryReader {geometry in
                                        Column(index: index, width: CGFloat(geometry.size.width / 2), currentIndex: $currentIndex)
                                            .frame(width: geometry.size.width, height: 200, alignment: .bottom)
                                            .onTapGesture {
                                                currentIndex = index
                                            }
                                    }
                                    .frame(height: 200, alignment: .bottom)
                                }
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        
                    }
                    .padding()
                
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .overlay(
            HStack {
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
                Spacer()
                Button(action: {
                    self.isLike.toggle()
                }, label: {
                    
                    Image(systemName: isLike ? "heart.fill" : "heart")
                        .foregroundColor(Color.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color.black.opacity(0.4))
                        .clipShape(Circle())
                })
            }
            .padding(.horizontal)
            , alignment: .top
        )
    }
}
struct Data {
    let value : Int
    let name : String
}
var data = [
    Data(value: 5900, name: "T.2"),
    Data(value: 5800, name: "T.3"),
    Data(value: 5700, name: "T.4"),
    Data(value: 5800, name: "T.5"),
    Data(value: 5600, name: "T.6"),
    Data(value: 6000, name: "T.7"),
    Data(value: 5900, name: "C.N"),
]
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(show: Binding.constant(false), showTabBar: Binding.constant(false))
    }
}
