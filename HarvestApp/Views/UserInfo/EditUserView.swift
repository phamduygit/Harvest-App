//
//  EditUserView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 06/07/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct EditUserView: View {
    @Binding var userInfo : UserInfo
    @State private var image : Image?
    @State private var showingImagePicker = false
    @State private var inputImage : UIImage?
    @EnvironmentObject var userViewModel : UserViewModel
    var body: some View {
        NavigationView {
            List {
                ZStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ảnh đại diện")
                            .font(.headline)
                        HStack {
                            Spacer()
                            Button(action: {
                                self.showingImagePicker = true
                            }, label: {
                                if image != nil {
                                    image?
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                } else {
                                    AnimatedImage(url: URL(string: userInfo.avatar))
                                        .resizable()
                                        .clipShape(Circle())
                                        .aspectRatio(contentMode: .fit)
                                }
                            })
                            Spacer()
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height / 3)
                VStack (alignment: .leading, spacing: 10 ) {
                    Text("Mô tả")
                        .font(.headline)
                    HStack {
                        TextField("Nhập mô tả", text: $userInfo.fullName)
                    }
                }

                VStack (alignment: .leading, spacing: 10 ) {
                    Text("Số điện thoại")
                        .font(.headline)
                    HStack {
                        TextField("Nhập số điện thoại", text: $userInfo.phone)
                    }
                }
                
            }
            .navigationTitle("Cập nhật thông tin")
        }
        .overlay(
            HStack {
                Spacer()
                Button(action: {
                    self.userViewModel.updateUserInfo(avatar: inputImage, userInfo: userInfo)
                }, label: {
                    Text("Lưu")
                })
                .padding()
            }
            , alignment: .bottom
        )
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
            VStack {
                ImagePicker(image: $inputImage)
            }
        })
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView(userInfo: Binding.constant(UserInfo()))
    }
}
