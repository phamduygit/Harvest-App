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
    var body: some View {
        NavigationView {
            VStack {
                
                VStack(alignment: .center) {
                    AnimatedImage(url: URL(string: userVM.userInfo.avatar))
                        .frame(width: 150, height: 150, alignment: .center)
                        .clipShape(Circle())
                    Text(userVM.userInfo.fullName)
                }
                List {
                    
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
                
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Cá nhân")
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
