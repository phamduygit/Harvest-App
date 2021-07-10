//
//  DetailNotificationView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI

struct DetailNotificationView: View {
    var notification: Notification
    @StateObject var postViewModel =  PostViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            PostCardInStock(post: postViewModel.getOnePost(postID: notification.postID))
            Divider()
            VStack(alignment: .leading, spacing: 5) {
                Text("Thông tin đặt cọc")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                HStack {
                    Text("Giá")
                    Spacer()
                    Text("\(notification.price, specifier: "%.0f") đ/kg")
                }
                HStack {
                    Text("Sản lượng")
                    Spacer()
                    Text("\(notification.bookWeight, specifier: "%.2f") kg")
                }
                HStack {
                    Text("Giá đặt cọc")
                    Spacer()
                    Text("\(notification.bookPrice, specifier: "%.0f") đồng")
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
                        Text(notification.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                    HStack(spacing: 15) {
                        Menu {
                            Text(notification.email)
                        } label: {
                            Image(systemName: "envelope.fill")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: .center)
                                .foregroundColor(Color.white)
                                .padding(10)
                                .background(Color.yellow)
                                .cornerRadius(10)
                        }

                        
                        Menu {
                            Text(notification.phone)
                        } label: {
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
        }
        .padding()
        .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
        .navigationBarTitle("Đặt cọc")
        
    }
}

struct DetailNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNotificationView(notification: Notification())
    }
}
