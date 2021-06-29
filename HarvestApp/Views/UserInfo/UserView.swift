//
//  UserView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 28/06/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct UserView: View {
    @Binding var isLogin : Bool
    var body: some View {
        VStack {
            AnimatedImage(url: Auth.auth().currentUser?.photoURL)
                .frame(width: 200, height: 200, alignment: .center)
            Button(action: {
                self.isLogin = false
                let firebaseAuth = Auth.auth()
                do {
                  try firebaseAuth.signOut()
                } catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)
                }
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
        UserView(isLogin: Binding.constant(false))
    }
}
