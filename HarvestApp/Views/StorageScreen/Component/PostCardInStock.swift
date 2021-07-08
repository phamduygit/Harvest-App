//
//  PostCardInStock.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 07/07/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore

struct PostCardInStock: View {
    var post: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                AnimatedImage(url: URL(string: post.avatar))
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(post.fullName)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                        Text(convertTimestamp(timestamp: post.createdTime))
                            .font(.subheadline)
                            .foregroundColor(Color.black.opacity(0.5))
                    }
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "multiply")
                            .foregroundColor(Color.black)
                    })
                    
                }
            }
            Text(post.description)
                .foregroundColor(Color.black)
            HStack(spacing: 10) {
                AnimatedImage(url: URL(string: post.image))
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(10)
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(post.productName)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                        Text("Sản lượng: \(post.weight, specifier: "%.2f") kg")
                            .foregroundColor(Color.black)
                        Text("Giá: \(post.price, specifier: "%.2f") đ/kg")
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                }
            }
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(15)
//            .onTapGesture {
//                self.isTapDetail.toggle()
//                self.showTabBar.toggle()
//            }
        }
        .padding()
        .background(Color.white)
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
}

struct PostCardInStock_Previews: PreviewProvider {
    static var previews: some View {
        PostCardInStock(post: Post())
    }
}
