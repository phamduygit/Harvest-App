//
//  ContentView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 09/06/2021.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("currentPage") var currentPage = 1
    @State var isLogin : Bool = true
    @State private var selection : Int = 0
    var body: some View {
//        Text("Current Page \(currentPage)")
        if currentPage > 3 {
            if isLogin {
                ZStack {
                    Color("Color4").edgesIgnoringSafeArea(.all)
                    VStack {
                        TabView(selection: $selection) {
                            HomeView()
                                .tag(0)
                            ProductsView()
                                .tag(1)
                            Text("Chợ nông sản")
                                .tag(3)
                            Text("Cá nhân")
                                .tag(4)
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        CustomTabBarView(selection: $selection)
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
            else {
                SignInView()
            }
        } else {
            OnboardingView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
