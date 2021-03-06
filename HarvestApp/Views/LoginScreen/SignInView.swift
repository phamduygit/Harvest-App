//
//  SignInView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 11/06/2021.
//

import SwiftUI

struct SignInView: View {
    var width =  UIScreen.main.bounds.size.width
    @EnvironmentObject var userVM: UserViewModel
    @State var email: String = ""
    @State var password : String = ""
    @State var showSignUpScreen : Bool = false
    @State var showForgotPasswordScreen : Bool = false
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Image("login")
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
                        InputSecureField(title: "Mật khẩu", placeHolder: "Nhập mật khẩu", inputText: $password)
                        Button(action: {
                            self.showForgotPasswordScreen.toggle()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Quên mật khẩu?")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.black.opacity(0.8))
                            }
                        })
                        .padding(.top, 10)
                        Spacer()
                        Button(action: {
                            userVM.logIn(email: email, password: password)
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Đăng nhập")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                Spacer()
                            }
                            .padding()
                            .background(Color("Color5"))
                            .cornerRadius(40)
                            
                        })
                        .padding(.horizontal)
                        HStack {
                            Spacer()
                            Text("Bạn không có tài khoản?")
                                .fontWeight(.medium)
                                .foregroundColor(Color.black.opacity(0.5))
                            Button(action: {
                                self.showSignUpScreen.toggle()
                            }, label: {
                                Text("Đăng ký")
                                    .foregroundColor(Color.black)
                                    .fontWeight(.bold)
                            })
                            
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color.white.ignoresSafeArea(.all, edges: .bottom))
                    .clipShape(RoundedBotton())
                }
                
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color("Color4"), Color.white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
            .alert(isPresented: $userVM.isError, content: {
                Alert(title: Text("Đăng nhập thất bại"), message: Text(userVM.errorDescription), dismissButton: .default(Text("OK")))
            })
            if showSignUpScreen {
                SignUpView(show: $showSignUpScreen)
            }
            if showForgotPasswordScreen {
                ForgotPasswordView(show: $showForgotPasswordScreen)
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}




