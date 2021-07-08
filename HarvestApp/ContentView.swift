//
//  ContentView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 09/06/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userVM = UserViewModel()
    @StateObject var postViewModel = PostViewModel()
    @AppStorage("currentPage") var currentPage = 1
    @State private var showTabBar = true
    @State private var selection : Int = 0
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
//        NavigationView {
//            VStack {
//                List(userVM.users) { user in
//                    Text(user.fullName)
//                }
//
//            }
//            .navigationTitle("Study Cards")
//        }
        if currentPage > 3 {
            if userVM.isLogin {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                    TabView(selection: $selection) {
                        HomeView()
                            .environmentObject(userVM)
                            .tag(0)
                        ProductsView(showTabBar: $showTabBar)
                            .tag(1)
                        MarketView(showTabBar: $showTabBar)
                            .environmentObject(postViewModel)
                            .tag(3)
                        UserView()
                            .environmentObject(userVM)
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
                    .environmentObject(userVM)
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
