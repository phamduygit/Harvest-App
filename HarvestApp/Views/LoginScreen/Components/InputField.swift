//
//  InputField.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 11/06/2021.
//

import Foundation
import SwiftUI

struct InputField: View {
    var title : String
    var placeHolder : String
    @Binding var inputText : String
    var body: some View {
        VStack (alignment: .leading, spacing: 10 ) {
            Text(title)
                .fontWeight(.bold)
                .font(.title2)
            TextField(placeHolder, text: $inputText)
            Divider()
        }
        .padding(.horizontal)
    }
}
