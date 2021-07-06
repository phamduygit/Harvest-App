//
//  UserView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 28/06/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserView: View {
    @EnvironmentObject var userVM : UserViewModel
    @State private var showEditUser : Bool = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Ảnh đại diện")) {
                        HStack {
                            Spacer()
                            AnimatedImage(url: URL(string: userVM.userInfo.avatar))
                                .frame(width: 150, height: 150, alignment: .center)
                                .clipShape(Circle())
                            Spacer()
                        }
                    }
                    Section(header: Text("Họ và tên")) {
                        Text(userVM.userInfo.fullName)
                    }
                    Section(header: Text("Email")) {
                        Text(userVM.userInfo.email)
                    }
                    Section(header: Text("Số điện thoại")) {
                        Text(userVM.userInfo.phone)
                    }
                    Button(action: {
                        userVM.isLogin = false
                        userVM.logOut()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Đăng xuất")
                                .font(.title2)
                            Spacer()
                        }
                    })
                    
                }
                .padding(.bottom, 50)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Cá nhân")
            .toolbar(content: {
                Button(action: {
                    showEditUser.toggle()
                }, label: {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(Color.black)
                })
            })
        }
        .sheet(isPresented: $showEditUser, content: {
            EditUserView(userInfo: $userVM.userInfo)
        })
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
