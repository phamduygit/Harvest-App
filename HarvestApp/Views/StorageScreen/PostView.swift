//
//  PostView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI

struct PostView: View {
    @State private var showDetailView : Bool = false
    @State private var selectedProdcut : Product = Product()
    @State private var selectedPost: Post = Post()
    @EnvironmentObject var stockViewModel : StockViewModel
    @EnvironmentObject var postViewModel : PostViewModel
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 10) {
                    ForEach(postViewModel.listPostInStock()) {post in
                        PostCardInStock(post: post)
                            .cornerRadius(10)
                            .onTapGesture {
                                self.selectedPost = post
                                selectedProdcut = getProduct()
                                print(selectedPost)
                                print(selectedProdcut)
                                self.showDetailView.toggle()
                            }
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color("Color4").ignoresSafeArea())
            .fullScreenCover(isPresented: $showDetailView, content: {
                DetailPostInStockView(show: $showDetailView, product: $selectedProdcut, post: $selectedPost)
            })
        }
    }
    func getProduct() -> Product{
        return stockViewModel.products.first { product in
            product.id == selectedPost.productID
        } ?? Product()
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
