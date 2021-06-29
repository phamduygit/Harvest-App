//
//  ListNotificationView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI

struct ListNotificationView: View {
    @State private var showDetail : Bool = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0..<5) {index in
                        NavigationLink(destination: DetailNotificationView()) {
                            NotificationView()
                        }
                    }
                }
            }
            .navigationTitle("Thông báo")
        }
    }
}

struct ListNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        ListNotificationView()
    }
}
