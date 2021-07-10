//
//  ListNotificationView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI

struct ListNotificationView: View {
    @State private var showDetail : Bool = false
    @StateObject private var userViewModel = UserViewModel()
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(userViewModel.notifications) { notification in
                        NavigationLink(destination: DetailNotificationView(notification: notification)) {
                            NotificationView(notification: notification)
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
