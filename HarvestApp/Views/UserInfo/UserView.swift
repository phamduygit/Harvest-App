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
        VStack {
            AnimatedImage(url: URL(string: userVM.userInfo.avatar))
                .frame(width: 150, height: 150, alignment: .center)
                .clipShape(Circle())
            Text(userVM.userInfo.fullName)
            Button(action: {
                userVM.isLogin = false
                userVM.logOut()
            }, label: {
                HStack {
                    Spacer()
                    Text("Đăng xuất")
                        .font(.title2)
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(30)
            })
            .padding()
            
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
