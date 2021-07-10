//
//  ItemCardView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 13/06/2021.
//

import SwiftUI
import FirebaseFirestore
import SDWebImageSwiftUI

struct ItemCardView: View {
    var item: Item
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        HStack {
            AnimatedImage(url: URL(string: item.image))
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(10)
            VStack(spacing: 8) {
                HStack {
                    Text(item.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        if isLove() {
                            userViewModel.removeFavorite(itemID: item.id!)
                        } else {
                            userViewModel.addFavorite(itemID: item.id!)
                        }
                    }, label: {
                        Image(systemName: isLove() ? "heart.fill": "heart")
                            .foregroundColor(Color.red)
                    })
                }
                HStack {
                    Text("Giá: \(item.price, specifier: "%.0f") đ")
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text("Ngày cập nhật: \(convertTimestamp(timestamp: item.updateTime))")
                        .font(.subheadline)
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
    func convertTimestamp(timestamp: Timestamp?) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        if timestamp != nil {
            let date = timestamp!.dateValue()
            let dateString = dateFormatterGet.string(from: date)
            return dateString
        } else {
            return "con coc"
        }
    }
    func isLove() -> Bool {
        return userViewModel.user.favorite.contains(item.id!)
    }
}

struct ItemCardView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCardView(item: Item())
    }
}

