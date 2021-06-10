//
//  OnboardingView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 09/06/2021.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
        ZStack {
            if (currentPage == 1) {
                OnboardingScreen(image: "onboarding1", title: "Tính toán thuận tiện", detail: "Giúp bạn tính sản lượng và doanh thu nông sản một cách thuận tiện", bgColor: Color("Color1"))
                    .transition(.scale)
            }
            if (currentPage == 2) {
                OnboardingScreen(image: "onboarding2", title: "Xem giá thị trường", detail: "Bản tin thị trường về nông sản sẽ được liên tục cập nhật để cung cấp cho bạn", bgColor: Color("Color2"))
                    .transition(.scale)
            }
            if (currentPage == 3) {
                OnboardingScreen(image: "onboarding3", title: "Tìm thương lái", detail: "Giúp cho bạn tìm kiếm thương lái phù hợp để bán nông sản", bgColor: Color("Color3"))
                    .transition(.scale)
            }
        }
        .overlay(
            Button(action: {
                withAnimation {
                    if currentPage <= 3 {
                        currentPage += 1
                    } else {
                        currentPage = 1
                    }
                }
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        ZStack {
                            Circle()
                                .stroke(Color.black.opacity(0.04), lineWidth: 4)
                            
                            Circle()
                                .trim(from: 0.0, to: CGFloat(currentPage) / CGFloat(3))
                                .stroke(Color.white, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-10)
                    )
            })
            .padding(.bottom, 20)
            ,alignment: .bottom
        )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct OnboardingScreen: View {
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
        VStack (spacing: 20) {
            HStack {
                if (currentPage == 1) {
                    Text("Xin chào bạn!")
                        .font(.title)
                        .fontWeight(.bold)
                }
                else {
                    // back button
                    Button(action: {
                        withAnimation(.easeInOut) {
                            currentPage -= 1
                        }
                        
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    })
                }
                Spacer()
                Button(action: {
                    currentPage = 4
                }, label: {
                    Text("Skip")
                        .kerning(1.4)
                        .foregroundColor(.black)
                })
            }
            .padding()
//            Spacer()
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            Text(detail)
                .fontWeight(.bold)
                .foregroundColor(Color.black.opacity(0.5))
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 120)
        }
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}
