//
//  LoginView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 10/06/2021.
//

import SwiftUI

struct LoginView: View {
    var width =  UIScreen.main.bounds.size.width
    @State var email: String = ""
    @State var password : String = ""
    var body: some View {
        VStack {
            Image("login")
                .resizable()
                
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: width * 9 / 16, alignment: .center)
            GeometryReader { geometry in
                VStack (alignment: .leading, spacing: 15) {
                    Text("Đăng nhập")
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(.top)
                        .padding(.bottom, 20)
                    InputField(title: "Email", placeHolder: "Nhập email", inputText: $email)
                    InputSecureField(title: "Mật khẩu", placeHolder: "Nhập mật khẩu", inputText: $password)
                    Button(action: {}, label: {
                        HStack {
                            Spacer()
                            Text("Quên mật khẩu?")
                                .fontWeight(.medium)
                                .foregroundColor(Color.black.opacity(0.8))
                        }
                    })
                    .padding(.top, 10)
                    Spacer()
                    Button(action: {}, label: {
                        HStack {
                            Spacer()
                            Text("Đăng nhập")
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
                    HStack {
                        Spacer()
                        Text("Bạn không có tài khoản?")
                            .fontWeight(.medium)
                            .foregroundColor(Color.black.opacity(0.5))
                        Text("Đăng ký")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    Divider()
                        .padding(.horizontal)
                    HStack (spacing: 30) {
                        Spacer()
                        Button(action: {}, label: {
                            Image("facebook - icon")
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        })
                        Button(action: {}, label: {
                            Image("gmail - icon")
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        })
                        
                        Spacer()
                    }
                    
                }
                .padding()
            }
            .background(Color.white.ignoresSafeArea())
            .clipShape(Rounded())
        }
        .background(Color("Color4").ignoresSafeArea(.all, edges: .top))
        
    }
}
struct Rounded : Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 40, height: 40))
        return Path(path.cgPath)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct InputField: View {
    var title : String
    var placeHolder : String
    @Binding var inputText : String
    var body: some View {
        VStack (alignment: .leading, spacing: 10 ) {
            Text(title)
                .fontWeight(.bold)
                .font(.title2)
            TextField(placeHolder, text: $inputText)
            Divider()
        }
        .padding(.horizontal)
    }
}
struct InputSecureField: View {
    @State private var showPassword: Bool = false
    var title : String
    var placeHolder : String
    @Binding var inputText : String
    var body: some View {
        VStack (alignment: .leading, spacing: 10 ) {
            Text(title)
                .fontWeight(.bold)
                .font(.title2)
            HStack {
                if showPassword {
                    TextField(placeHolder, text: $inputText)
                } else {
                    SecureField(placeHolder, text: $inputText)
                }
                Button(action: {
                    self.showPassword.toggle()
                }, label: {
                    if showPassword {
                        Image(systemName: "eye")
                            .foregroundColor(Color.black)
                    }
                    else {
                        Image(systemName: "eye.slash")
                            .foregroundColor(Color.black)
                    }
                })
            }
            Divider()
        }
        .padding(.horizontal)
    }
}
