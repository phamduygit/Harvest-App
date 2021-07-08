//
//  MarketView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI

struct MarketView: View {
    @State private var filter = FilterCategory.all
    enum FilterCategory: String, CaseIterable, Identifiable {
        case all = "Tất cả"
        case rice = "Lúa"
        case coffee = "Cà phê"
        case blackPepper = "Tiêu"
        case lychee = "Vải"
        var id: FilterCategory { self }
    }
    @State private var showDetailPost : Bool = false
    @State private var selectedPost = Post()
    @State private var showBookMark = false
    @Binding var showTabBar : Bool
    @EnvironmentObject var postViewModel : PostViewModel
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack {
                    Text("Chợ nông sản")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Menu {
                        Picker(selection: $filter, label: Text("Picker"), content: {
                            ForEach(FilterCategory.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        })
                        Toggle(isOn: $showBookMark) {
                            Label("Đã đánh dấu", systemImage: "heart.fill")
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(Color.black)
                    }

                }
                .padding(.horizontal)
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 10) {
                        ForEach(postViewModel.filtered(category: filter.rawValue)) {post in
                            PostCard(post: post, showTabBar: $showTabBar)
                                .cornerRadius(10)
                                .onTapGesture {
                                    showDetailPost.toggle()
                                }
                        }
                    }
                    .padding()
                }

            }
            .background(Color("Color4").ignoresSafeArea(.all, edges: .all))
            if showDetailPost {
                DetailPostView(show: $showDetailPost, showTabBar: $showTabBar, post: $selectedPost)
            }
        }
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView(showTabBar: Binding.constant(false))
    }
}
