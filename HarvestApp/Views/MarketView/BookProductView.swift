//
//  BookProductView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 09/07/2021.
//

import SwiftUI

struct BookProductView: View {
    @Binding var show: Bool
    @Binding var post: Post
    @ObservedObject var price = NumbersOnly()
    @ObservedObject var bookPrice = NumbersOnly()
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var postViewModel : PostViewModel
    @State private var message: String = ""
    @State private var notification = Notification()
    @State private var showAlert: Bool = false
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack (spacing: 10) {
                        HStack {
                            Text("Tên nông sản")
                                .font(.headline)
                            Spacer()
                            Text(post.productName)
                                .font(.headline)
                                .foregroundColor(Color.black.opacity(0.4))
                        }
                        .padding(.vertical)
                        VStack (alignment: .leading, spacing: 10 ) {
                            Text("Sản lượng")
                                .font(.headline)
                            HStack {
                                Text("\(post.weight, specifier: "%.2f")")
                                Spacer()
                                Text("kg")
                            }
                            Divider()
                        }
                        VStack (alignment: .leading, spacing: 10 ) {
                            Text("Giá")
                                .font(.headline)
                            HStack {
                                TextField("Nhập giá", text: $price.value)
                                    .keyboardType(.decimalPad)
                                    .onAppear() {
                                        price.value = String(format: "%.0f", (post.price))
                                    }
                                Spacer()
                                Text("đồng")
                            }
                            Divider()
                        }
                        VStack (alignment: .leading, spacing: 10 ) {
                            Text("Giá đặt cọc")
                                .font(.headline)
                            HStack {
                                TextField("Nhập giá đặt cọc", text: $bookPrice.value)
                                    .keyboardType(.decimalPad)
                                Spacer()
                                Text("đồng")
                            }
                            Divider()
                        }
                        VStack (alignment: .leading, spacing: 10 ) {
                            Text("Tin nhắn")
                                .font(.headline)
                            HStack {
                                TextField("Nhập tin nhắn", text: $message)
                                Spacer()
                            }
                            Divider()
                        }
                    }
                    .padding()
                    .padding(.bottom, 80)
                    Spacer()
                }
            }
            .overlay(
                HStack(spacing: 30) {
                    Button(action: {
                        show.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Huỷ")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.gray)
                        .clipShape(Capsule())
                    })
                    Button(action: {
                        if price.value == "" || bookPrice.value == "" || message == "" {
                            showAlert.toggle()
                        } else {
                            notification.avatar = userViewModel.user.avatar
                            notification.name = userViewModel.user.fullName
                            notification.userID = userViewModel.user.userId
                            notification.email = userViewModel.user.email
                            notification.phone = userViewModel.user.phone
                            notification.message = message
                            notification.postID = post.id!
                            notification.price = (price.value as NSString).floatValue
                            notification.bookWeight = post.weight
                            notification.bookPrice = (bookPrice.value as NSString).floatValue
                            userViewModel.addNotification(notification: notification, userID: post.userID)
                            show.toggle()
                        }
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Gửi")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color("Color5"))
                        .clipShape(Capsule())
                    })
                }
                .padding(.horizontal)
                .padding(.bottom)
                , alignment: .bottom
            )
            .navigationBarTitle("Đặt cọc nông sản")
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Chưa nhập đủ thông tin"), message: Text("Yêu cầu bạn phải nhập đầy thông tin"), dismissButton: .default(Text("OK")))
            })
        }
    }
}

struct BookProductView_Previews: PreviewProvider {
    static var previews: some View {
        BookProductView(show: Binding.constant(false), post: Binding.constant(Post()))
    }
}
