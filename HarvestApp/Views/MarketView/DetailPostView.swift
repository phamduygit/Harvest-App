//
//  DetailPostVIew.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailPostView: View {
    @Binding var post: Post
    @Binding var show: Bool
    @State private var showBookProduct: Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                AnimatedImage(url: URL(string: post.image))
                    .resizable()
                    .frame(height: UIScreen.main.bounds.height  * 2 / 5)
                VStack {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(post.fullName)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                            }
                            Spacer()
                            HStack(spacing: 15) {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color.white)
                                    .padding(10)
                                    .background(Color.yellow)
                                    .cornerRadius(10)
                                Image(systemName: "phone.fill")
                                    .foregroundColor(Color.white)
                                    .padding(10)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.bottom, 10)
                        Divider()
                        VStack(alignment: .leading, spacing: 10) {
                            Text(post.productName)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            HStack {
                                Text("Gi??")
                                    .foregroundColor(Color.black.opacity(0.5))
                                Spacer()
                                Text("\(post.price, specifier: "%.0f") ??/kg")
                                    .foregroundColor(Color.black.opacity(0.5))
                            }
                            HStack {
                                Text("S???n l?????ng")
                                    .foregroundColor(Color.black.opacity(0.5))
                                Spacer()
                                Text("\(post.weight, specifier: "%.2f") kg")
                                    .foregroundColor(Color.black.opacity(0.5))
                            }
                            HStack {
                                Text("T???ng")
                                    .foregroundColor(Color.black.opacity(0.5))
                                Spacer()
                                Text("\(post.price * post.weight, specifier: "%.0f") ?????ng")
                                    .foregroundColor(Color.black.opacity(0.5))
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedTop())
                    .offset(y: -50)
                    Spacer()
                    
                }
                .background(Color.white)
            }
        }
        .sheet(isPresented: $showBookProduct, content: {
            BookProductView(show: $showBookProduct, post: $post)
        })
        .ignoresSafeArea(.all, edges: .all)
        .overlay(
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
            .padding(.leading),
            alignment: .topLeading
        )
        .overlay(
            Button(action: {
                showBookProduct.toggle()
            }, label: {
                HStack {
                    Spacer()
                    Text("?????t c???c")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding()
                .background(Color("Color5"))
                .cornerRadius(40)
            })
            .padding(),
            alignment: .bottom
        )
    }
}

struct DetailPostVIew_Previews: PreviewProvider {
    static var previews: some View {
        DetailPostView(post: Binding.constant(Post()), show: Binding.constant(false))
    }
}
