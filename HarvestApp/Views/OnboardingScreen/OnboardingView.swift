//
//  OnboardingView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 09/06/2021.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack {
            OnboardingScreen(image: "onboarding1", title: "Tính toán thuận tiện", detail: "Giúp bạn tính sản lượng và doanh thu nông sản một cách thuận tiện", bgColor: Color("Color1"))
        }
        .overlay(
            Button(action: {}, label: {
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
                                .trim(from: 0.0, to: 0.3)
                                .stroke(Color.white, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-10)
                    )
                    .padding()
            }),
            alignment: .bottom
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
    var body: some View {
        VStack (spacing: 20) {
            HStack {
                Text("Xin chào bạn!")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {}, label: {
                    Text("Skip")
                        .kerning(1.4)
                        .foregroundColor(.black)
                })
            }
            .padding()
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
            
            Spacer()
        }
        .background(Color("Color1").ignoresSafeArea())
    }
}
