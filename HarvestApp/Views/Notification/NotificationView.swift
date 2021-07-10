//
//  NotificationView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 24/06/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore

struct NotificationView: View {
    var notification: Notification
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            AnimatedImage(url: URL(string: notification.avatar))
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 5) {
                Text("\(notification.name) muốn đặt cọc nông sản của bạn: \(notification.message)")
                    .font(.headline)
                Text(convertTimestamp(timestamp: notification.timeSend))
                    .font(.subheadline)
            }
        }
    }
    func convertTimestamp(timestamp: Timestamp?) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm dd/MM/yyyy"
        if timestamp != nil {
            let date = timestamp!.dateValue()
            let dateString = dateFormatterGet.string(from: date)
            return dateString
        } else {
            return "con coc"
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(notification: Notification())
    }
}
