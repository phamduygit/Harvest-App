//
//  SignUpView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 11/06/2021.
//

import SwiftUI

struct SignUpView: View {
    var width =  UIScreen.main.bounds.size.width
    @Binding var show : Bool
    @State var email: String = ""
    @State var password : String = ""
    @State var fullName : String = ""
    @State var numberPhone : String = ""
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Image("login")
                    .resizable()
                    
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: width * 9 / 16, alignment: .center)
                
                VStack (alignment: .leading, spacing: 15) {
                    Text("Đăng ký")
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(.top)
                        .padding(.bottom, 20)
                    Group {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Ảnh đại diện")
                                .font(.title2)
                                .fontWeight(.bold)
                            HStack {
                                Spacer()
                                Button(action: {}, label: {
                                    Image(systemName: "camera.fill")
                                        .foregroundColor(.black)
                                        .padding(40)
                                        .background(Color.gray.opacity(0.5))
                                        .clipShape(Circle())
                                })
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        InputField(title: "Họ và tên", placeHolder: "Nhập họ và tên", inputText: $fullName)
                        InputField(title: "Email", placeHolder: "Nhập email", inputText: $fullName)
                        InputField(title: "Số điện thoại", placeHolder: "Nhập số điện thoại", inputText: $numberPhone)
                        InputSecureField(title: "Mật khẩu", placeHolder: "Nhập mật khẩu", inputText: $password)
                    }
                    
                    .padding(.top, 10)
                    Spacer()
                    Button(action: {}, label: {
                        HStack {
                            Spacer()
                            Text("Đăng ký")
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
                }
                .padding()
                .background(Color.white.ignoresSafeArea(.all, edges: .bottom))
                .clipShape(RoundedBotton())
            }
            
        }
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

struct SignUpView_Previews: PreviewProvider {
    @State static var value = false
    static var previews: some View {
        SignUpView(show: $value)
    }
}
