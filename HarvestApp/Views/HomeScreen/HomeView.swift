//
//  HomeView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 09/06/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var itemViewModel : ItemViewModel
    @EnvironmentObject var postViewModel : PostViewModel
    @State private var key : String = ""
    @State private var isLike : Bool = true
    @State private var showNotification : Bool = false
    @State private var selectedItem = Item()
    @State private var showDetailProduct = false
    @State private var selectedPost = Post()
    @State private var showDetailPost = false
    @State private var limit = 0
    var body: some View {
        ZStack {
            VStack (alignment: .leading){
                ZStack {
                    HStack {
                        AnimatedImage(url: URL(string: userViewModel.user.avatar))
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipShape(Circle())
                        Spacer()
                        Button(action: {
                            showNotification.toggle()
                        }, label: {
                            Image(systemName: "bell")
                                .resizable()
                                .frame(width: 24, height: 24, alignment: .center)
                                .foregroundColor(Color.black)
                        })
                    }
                    .padding(.horizontal)
                    VStack {
                        Text("Chào buổi sáng")
                        Text(userViewModel.user.fullName)
                            .fontWeight(.bold)
                    }
                }
                .sheet(isPresented: $showNotification) {
                    ListNotificationView()
                }
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        Text("Nông sản yêu thích")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (spacing: 15) {
                            ForEach(itemViewModel.listItemFavorite(favorites: userViewModel.user.favorite)) { item in
                                CardView(item: item)
                                    .onTapGesture {
                                        selectedItem = item
                                        showDetailProduct.toggle()
                                    }
                                    
                            }
                        }
                        .padding(.leading)
                    }
                    
                    HStack {
                        Text("Các bài đăng mới nhất")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading)
                        Spacer()
                    }
                    VStack {
                        ForEach(postViewModel.limitedPosts) {post in
                            PostCard(post: post)
                                .padding(.horizontal)
                                .onTapGesture {
                                    selectedPost = post
                                    showDetailPost.toggle()
                                }
                        }
                    }
                    .padding(.bottom, 60)
                }
            }
            
            .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
        }
        .fullScreenCover(isPresented: $showDetailProduct, content: {
            ProductDetailView(show: $showDetailProduct, selectedItem: $selectedItem)
        })
        .fullScreenCover(isPresented: $showDetailPost) {
            DetailPostView(post: $selectedPost, show: $showDetailPost)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
