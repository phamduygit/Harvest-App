//
//  NotificationView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image("avatar")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
            VStack(alignment: .leading, spacing: 5) {
                Text("Trần Long muốn đặt cọc: tôi muốn mua lúa jasmine của của bạn")
                    .font(.headline)
                Text("10:00 24/07/2021")
                    .font(.subheadline)
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
