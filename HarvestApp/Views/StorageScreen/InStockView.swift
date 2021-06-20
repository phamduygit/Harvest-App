//
//  InStockView.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 20/06/2021.
//

import SwiftUI

struct InStockView: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            HStack {
                Button(action: {
                    self.show.toggle()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.black)
                })
                Spacer()
            }
            .padding()
            Text("Thu hoạch")
                .font(.title2)
                .fontWeight(.medium)
        }
    }
}

struct InStockView_Previews: PreviewProvider {
    static var previews: some View {
        InStockView()
    }
}
