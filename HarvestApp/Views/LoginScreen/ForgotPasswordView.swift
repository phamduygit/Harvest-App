//
//  ForgotPasswordView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 11/06/2021.
//

import SwiftUI

struct ForgotPasswordView: View {
    var width =  UIScreen.main.bounds.size.width
    @State var email: String = ""
    @State var password : String = ""
    @Binding var show : Bool
    var body: some View {
        VStack {
            Image("forgotpassword")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: width * 9 / 16, alignment: .center)
            VStack (alignment: .leading, spacing: 15) {
                Text("Đăng nhập")
                    .fontWeight(.bold)
                    .font(.title2)
                    .padding(.top)
                    .padding(.bottom, 20)
                InputField(title: "Email", placeHolder: "Nhập email", inputText: $email)

                Button(action: {}, label: {
                    HStack {
                        Spacer()
                        Text("Gửi")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding()
                    .background(Color("Color5"))
                    .cornerRadius(40)
                })
                .padding(.horizontal)
                Spacer()
            }
            
            .padding()
            .background(Color.white.ignoresSafeArea(.all, edges: .bottom))
            .clipShape(RoundedBotton())
            .offset(x: 0, y: -20)
        }
//        .background(Color.blue.ignoresSafeArea())
        .background(LinearGradient(gradient: Gradient(colors: [Color("Color4"), Color.white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
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
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        ForgotPasswordView(show: $value)
    }
}
