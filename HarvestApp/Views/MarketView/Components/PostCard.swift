//
//  PostCard.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore

struct PostCard: View {
    var post: Post
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                AnimatedImage(url: URL(string: post.avatar))
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(post.fullName)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                        Text(convertTimestamp(timestamp: post.createdTime))
                            .font(.subheadline)
                            .foregroundColor(Color.black.opacity(0.5))
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                    Button(action: {
                        if isMark() {
                            userViewModel.removeBookmark(postID: post.id!)
                        } else {
                            userViewModel.addBookmark(postID: post.id!)
                        }
                    }, label: {
                        Image(systemName: isMark() ? "bookmark.fill": "bookmark")
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
                        Text("Giá: \(post.price, specifier: "%.0f") đ/kg")
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                }
            }
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(15)
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
    func isMark() -> Bool {
        return userViewModel.user.bookmarks.contains(post.id!)
    }
}

struct PostCard_Previews: PreviewProvider {
    static var previews: some View {
        PostCard(post: Post())
    }
}
