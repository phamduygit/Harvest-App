//
//  ContentView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 09/06/2021.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("currentPage") var currentPage = 1
    @State private var showTabBar = true
    @State var isLogin : Bool = true
    @State private var selection : Int = 0
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
//        Text("Current Page \(currentPage)")
        if currentPage > 3 {
            if isLogin {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                    TabView(selection: $selection) {
                        HomeView()
                            .tag(0)
                        ProductsView(showTabBar: $showTabBar)
                            .tag(1)
                        Text("Chợ nông sản")
                            .tag(3)
                        Text("Cá nhân")
                            .tag(4)
                    }
                    if showTabBar {
                        CustomTabBarView(selection: $selection)
                    }
                    
                }
                .ignoresSafeArea(.all, edges: .bottom)
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
