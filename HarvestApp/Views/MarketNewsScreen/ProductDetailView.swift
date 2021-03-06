//
//  ProductDetailView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 13/06/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    enum chose: String, CaseIterable {
        case week = "Tuần"
        case month = "Tháng"
    }
    @State private var currentIndex = 0
    @State private var selection : chose = .week
    @State private var isLike : Bool = false
    @EnvironmentObject var userViewModel : UserViewModel
    @Binding var show : Bool
    @Binding var selectedItem: Item
    var body: some View {
        ZStack {
            Color("Color4").ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack(spacing: 10) {
                        AnimatedImage(url: URL(string: selectedItem.image))
                            .resizable()
                            .frame(height: UIScreen.main.bounds.height / 3)
                            .clipShape(RoundedBotton(cornerRaidus: 40))
                        VStack(spacing: 10) {
                            HStack {
                                Text(selectedItem.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("\(selectedItem.price, specifier: "%.0f") đ/kg")
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
                                    Text(selectedItem.category)
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
                        Text(selectedItem.description)
                        
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
                    if isLove() {
                        userViewModel.removeFavorite(itemID: selectedItem.id!)
                    } else {
                        userViewModel.addFavorite(itemID: selectedItem.id!)
                    }
                }, label: {
                    Image(systemName: isLove() ? "heart.fill": "heart")
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
    func isLove() -> Bool {
        return userViewModel.user.favorite.contains(selectedItem.id!)
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
        ProductDetailView(show: Binding.constant(false), selectedItem: Binding.constant(Item()))
    }
}
