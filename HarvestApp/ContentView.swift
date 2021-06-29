//
//  ContentView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 09/06/2021.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @AppStorage("currentPage") var currentPage = 1
    @State private var showTabBar = true
    @State var isLogin : Bool = Auth.auth().currentUser != nil ? true : false
    @State private var selection : Int = 0
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        if currentPage > 3 {
            if isLogin {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                    TabView(selection: $selection) {
                        HomeView()
                            .tag(0)
                        ProductsView(showTabBar: $showTabBar)
                            .tag(1)
                        MarketView(showTabBar: $showTabBar)
                            .tag(3)
                        UserView(isLogin: $isLogin)
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
