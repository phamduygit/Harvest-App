//
//  ContentView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 09/06/2021.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("currentPage") var currentPage = 1
    @State var isLogin : Bool = false
    var body: some View {
//        Text("Current Page \(currentPage)")
        if currentPage > 3 {
            if isLogin {
                HomeView()
            }
            else {
                LoginView()
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
